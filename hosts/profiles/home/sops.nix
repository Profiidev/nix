{ inputs, ... }:

let
  sopsFolder = (builtins.toString inputs.nix-secrets) + "/sops";
  homeDirectory = config.home.homeDirectory;
in 
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];
  sops = {
    age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = "${sopsFolder}/${config.hostSpec.hostName}.yaml";
    validateSopsFiles = false;

    secrets = {
      builtins.trace "Secrets: " sops.secrets;
      #map (key: ) (builtins.attrNames sops.secrets)
      "ssh_keys/general" = {
        mode = "0600";
        sopsFile = "${sopsFolder}/shared.yaml";
        path = "${homeDirectory}/.ssh/id_${name}";
      };
    };
  };
}