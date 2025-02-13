{ inputs, hostSpec, lib, config, ... }:

let
  sopsFolder = (builtins.toString inputs.nix-secrets) + "/sops";
  homeDirectory = config.home.homeDirectory;
  generalKeys = [
    "config"
    "secrets"
  ];
in 
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  sops = {
    age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = "${sopsFolder}/${hostSpec.hostname}.yaml";
    validateSopsFiles = false;

    secrets = builtins.listToAttrs (map (name: {
      name = "ssh_keys/${hostSpec.username}/${name}";
      value = {
        mode = "0600";
        sopsFile = "${sopsFolder}/shared.yaml";
        path = "${homeDirectory}/.ssh/id_${name}";
      };
    }) hostSpec.ssh_keys)
    //
    builtins.listToAttrs (map (name: {
      name = "ssh_keys/${hostSpec.username}/${name}_pub";
      value = {
        mode = "0600";
        sopsFile = "${sopsFolder}/shared.yaml";
        path = "${homeDirectory}/.ssh/id_${name}.pub";
      };
    }) hostSpec.ssh_keys)
    //
    builtins.listToAttrs (map (name: {
      name = "ssh_keys/general/${name}";
      value = {
        mode = "0600";
        sopsFile = "${sopsFolder}/shared.yaml";
        path = "${homeDirectory}/.ssh/id_${name}";
      };
    }) generalKeys)
    //
    builtins.listToAttrs (map (name: {
      name = "ssh_keys/general/${name}_pub";
      value = {
        mode = "0600";
        sopsFile = "${sopsFolder}/shared.yaml";
        path = "${homeDirectory}/.ssh/id_${name}.pub";
      };
    }) generalKeys);
  };
}