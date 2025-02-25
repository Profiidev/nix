{ inputs, hostSpec, config, ... }:

let
  sopsFolder = (builtins.toString inputs.nix-secrets) + "/sops";
  homeDirectory = config.home.homeDirectory;
  generalKeys = [ "config" "secrets" ];
  userSpec = config.userSpec;
in {
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = "${sopsFolder}/${hostSpec.hostname}.yaml";
    validateSopsFiles = false;

    secrets = builtins.listToAttrs (map (name: {
      name = "ssh_keys/${userSpec.username}/${name}";
      value = {
        mode = "0600";
        sopsFile = "${sopsFolder}/shared.yaml";
        path = "${homeDirectory}/.ssh/id_${name}";
      };
    }) userSpec.ssh_keys) // builtins.listToAttrs (map (name: {
      name = "ssh_keys/${userSpec.username}/${name}_pub";
      value = {
        mode = "0600";
        sopsFile = "${sopsFolder}/shared.yaml";
        path = "${homeDirectory}/.ssh/id_${name}.pub";
      };
    }) userSpec.ssh_keys) // builtins.listToAttrs (map (name: {
      name = "ssh_keys/general/${name}";
      value = {
        mode = "0600";
        sopsFile = "${sopsFolder}/shared.yaml";
        path = "${homeDirectory}/.ssh/id_${name}";
      };
    }) generalKeys) // builtins.listToAttrs (map (name: {
      name = "ssh_keys/general/${name}_pub";
      value = {
        mode = "0600";
        sopsFile = "${sopsFolder}/shared.yaml";
        path = "${homeDirectory}/.ssh/id_${name}.pub";
      };
    }) generalKeys) // {
      "yubikey/pins/${userSpec.username}" = {
        sopsFile = "${sopsFolder}/shared.yaml";
      };

      "keyring_keys/${userSpec.username}" = {
        sopsFile = "${sopsFolder}/shared.yaml";
      };
    };
  };

  sops.templates."yubikey_pin".content = ''
    PIN="${config.sops.placeholder."yubikey/pins/${userSpec.username}"}"
  '';
}
