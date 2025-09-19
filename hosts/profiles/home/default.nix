{ inputs, ... }:

{
  imports = [
    ./hardware-config.nix

    ../../spec.nix

    # Profiles
    ../../../modules/profiles/system/base.nix
    ../../../modules/profiles/system/coding.nix
    ../../../modules/profiles/system/gaming.nix
    ../../../modules/profiles/system/pc.nix

    ../../../modules/profiles/apps/base.nix
    ../../../modules/profiles/apps/gaming.nix
    ../../../modules/profiles/apps/graphics.nix
    ../../../modules/profiles/apps/office.nix

    # Extra
    ../../../modules/apps/tailscale.nix
  ];

  hostSpec = {
    hostname = "home";
    users = [
      inputs.nix-secrets.users.profidev
      {
        username = "root";
        secrets_user = "root";
      }
    ];
  };
}
