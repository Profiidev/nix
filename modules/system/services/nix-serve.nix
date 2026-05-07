{ config, pkgs, lib, ... }:

{
  services.nix-serve = {
    enable = true;

    package = pkgs.nix-serve-ng;
    extraParams = lib.concatStringsSep " " [
      "--priority 100"
    ];

    secretKeyFile = config.sops.secrets."store_key/private".path;
  };
}
