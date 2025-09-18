{
  lib,
  config,
  inputs,
  ...
}:

let
  sopsFolder = builtins.toString inputs.nix-secrets + "/sops";

  home = user: if user.username == "root" then "/root" else "/home/${user.username}";
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
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
          "keys/age_${spec.username}" = {
            owner = config.users.users.${spec.username}.name;
            inherit (config.users.users.${spec.username}) group;
            # We need to ensure the entire directory structure is that of the user...
            path = "${home spec}/.config/sops/age/keys.txt";
            key = "keys/age";
          };
          # extract password/username to /run/secrets-for-users/ so it can be used to create the user
          "passwords/${spec.username}" = {
            sopsFile = "${sopsFolder}/shared.yaml";
            neededForUsers = true;
          };

          "yubikey/login/${config.hostSpec.hostname}/${spec.username}" = lib.mkIf (spec.use_yubikey) {
            owner = config.users.users.${spec.username}.name;
            inherit (config.users.users.${spec.username}) group;

            sopsFile = "${sopsFolder}/shared.yaml";
            path = "${home spec}/.config/Yubico/u2f_keys";
          };
        }
      )
      {
        "store_key/private" = {
          sopsFile = "${sopsFolder}/shared.yaml";
          owner = "root";
          group = "root";
        };

        "store_key/public" = {
          sopsFile = "${sopsFolder}/shared.yaml";
          owner = "root";
          group = "root";
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
          group = config.users.users.${spec.username}.group;
        in
        ''
          mkdir -p ${ageFolder} || true
          mkdir -p ${keyFolder} || true
          chown -R ${user}:${group} ${home spec}/.config
        '';
    }
  ) { } config.hostSpec.users;
}
