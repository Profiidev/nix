{
  pkgs,
  lib,
  config,
  inputs,
  isDarwin,
  ...
}:

let
  sopsFolder = builtins.toString inputs.nix-secrets + "/sops";
  platform = if isDarwin then "darwin" else "nixos";
  platformModules = "${platform}Modules";
  isLinux = pkgs.stdenv.isLinux;

  home =
    user:
    if isDarwin then
      "/Users/${user.username}"
    else
      (if user.username == "root" then "/root" else "/home/${user.username}");
in
{
  imports = [
    inputs.sops-nix.${platformModules}.sops
  ];

  sops = {
    defaultSopsFile = "${sopsFolder}/${config.hostSpec.hostname}.yaml";
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
  };

  sops.secrets =
    lib.foldl
      (
        acc: spec:
        acc
        // {
          # These age keys are are unique for the user on each host and are generated on their own (i.e. they are not derived
          # from an ssh key).
          "keys/age_${spec.secrets_user}" = {
            owner = config.users.users.${spec.username}.name;
            #inherit (config.users.users.${spec.username}) group;
            # We need to ensure the entire directory structure is that of the user...
            path = "${home spec}/.config/sops/age/keys.txt";
            key = "keys/age";
          };
          # extract password/username to /run/secrets-for-users/ so it can be used to create the user
          "passwords/${spec.secrets_user}" = {
            sopsFile = "${sopsFolder}/shared.yaml";
            neededForUsers = true;
          };
        }
        // (
          if isLinux then
            {
              "yubikey/login/${config.hostSpec.hostname}/${spec.secrets_user}" = lib.mkIf (spec.use_yubikey) {
                owner = config.users.users.${spec.username}.name;
                #inherit (config.users.users.${spec.username}) group;

                sopsFile = "${sopsFolder}/shared.yaml";
                path = "${home spec}/.config/Yubico/u2f_keys";
              };
            }
          else
            { }
        )
      )
      {
        "store_key/private" = {
          sopsFile = "${sopsFolder}/shared.yaml";
          owner = "root";
          group = "wheel";
        };

        "store_key/public" = {
          sopsFile = "${sopsFolder}/shared.yaml";
          owner = "root";
          group = "wheel";
        };
      }
      config.hostSpec.users;

  system.activationScripts = lib.foldl (
    acc: spec:
    acc
    // {
      "sopsSetAgeKeyOwnership_${spec.username}" =
        let
          ageFolder = "${home spec}/.config/sops/age";
          keyFolder = "${home spec}/.config/Yubico";
          user = config.users.users.${spec.username}.name;
        in
        ''
          mkdir -p ${ageFolder} || true
          mkdir -p ${keyFolder} || true
        '';
    }
  ) { } config.hostSpec.users;
}
