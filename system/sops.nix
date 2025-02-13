{ lib, config, inputs, ... }:

let
  sopsFolder = builtins.toString inputs.nix-secrets + "/sops";
in
{
  sops = {
    defaultSopsFile = "${sopsFolder}/${config.hostSpec.hostname}.yaml";
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
  };

  sops.secrets = lib.mkMerge [
    {
      # These age keys are are unique for the user on each host and are generated on their own (i.e. they are not derived
      # from an ssh key).

      # FIXME(starter-repo):
      #    "keys/age/${config.hostSpec.username}_${config.networking.hostName}" = {
      "keys/age" = {
        owner = config.users.users.${config.hostSpec.username}.name;
        inherit (config.users.users.${config.hostSpec.username}) group;
        # We need to ensure the entire directory structure is that of the user...
        path = "${config.hostSpec.home}/.config/sops/age/keys.txt";
      };
      # extract password/username to /run/secrets-for-users/ so it can be used to create the user
      "passwords/${config.hostSpec.username}" = {
        sopsFile = "${sopsFolder}/shared.yaml";
        neededForUsers = true;
      };
    }
  ];

  system.activationScripts.sopsSetAgeKeyOwnership =
    let
      ageFolder = "${config.hostSpec.home}/.config/sops/age";
      user = config.users.users.${config.hostSpec.username}.name;
      group = config.users.users.${config.hostSpec.username}.group;
    in
    ''
      mkdir -p ${ageFolder} || true
      chown -R ${user}:${group} ${config.hostSpec.home}/.config
    '';
}