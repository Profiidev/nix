{ config, ... }:

{
  services.nix-serve = {
    enable = true;
    secretKeyFile = config.sops.secrets."store_key/private".path;
  };
}
