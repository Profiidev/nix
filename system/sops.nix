{ lib, config, inputs, ... }:

let sopsFolder = builtins.toString inputs.nix-secrets + "/sops";
in {
  sops = {
    defaultSopsFile = "${sopsFolder}/${config.hostSpec.hostname}.yaml";
    validateSopsFiles = false;

    age = { sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; };
  };

  sops.secrets = lib.mkMerge [{
    # These age keys are are unique for the user on each host and are generated on their own (i.e. they are not derived
    # from an ssh key).

    # FIXME(starter-repo):
    #    "keys/age/${config.userSpec.username}_${config.networking.hostName}" = {
    "keys/age" = {
      owner = config.users.users.${config.userSpec.username}.name;
      inherit (config.users.users.${config.userSpec.username}) group;
      # We need to ensure the entire directory structure is that of the user...
      path = "${config.userSpec.home}/.config/sops/age/keys.txt";
    };
    # extract password/username to /run/secrets-for-users/ so it can be used to create the user
    "passwords/${config.userSpec.username}" = {
      sopsFile = "${sopsFolder}/shared.yaml";
      neededForUsers = true;
    };
    "passwords/root" = {
      sopsFile = "${sopsFolder}/shared.yaml";
      neededForUsers = true;
    };
  }];

  system.activationScripts.sopsSetAgeKeyOwnership = let
    ageFolder = "${config.userSpec.home}/.config/sops/age";
    user = config.users.users.${config.userSpec.username}.name;
    group = config.users.users.${config.userSpec.username}.group;
  in ''
    mkdir -p ${ageFolder} || true
    chown -R ${user}:${group} ${config.userSpec.home}/.config
  '';
}
