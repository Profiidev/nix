{ inputs, ... }:

{
  imports = [
    ./hardware-config.nix

    ../../spec.nix

    # Profiles
    ../../../modules/profiles/system/base.nix
    ../../../modules/profiles/system/coding.nix
    ../../../modules/profiles/system/laptop.nix
    ../../../modules/system/services/dms.nix

    ../../../modules/profiles/apps/base.nix
    ../../../modules/profiles/apps/graphics.nix
    ../../../modules/profiles/apps/office.nix

    # Extra
    ../../../modules/apps/tailscale.nix
    ../../../modules/apps/cloudflare.nix
  ];

  hostSpec = {
    hostname = "laptop";
    users = [
      inputs.nix-secrets.users.profidev
      {
        username = "root";
        secrets_user = "root";
      }
    ];
  };
}
