{ inputs, ... }:

{
  imports = [
    ./hardware-config.nix

    ../../spec.nix

    # Profiles
    ../../../system/profiles/base.nix
    ../../../system/profiles/coding_graphics.nix
    ../../../system/profiles/coding.nix
    ../../../system/profiles/gaming.nix
    ../../../system/profiles/graphics.nix
    ../../../system/profiles/office.nix
    ../../../system/profiles/pc.nix

    # Extra
    ../../../system/media/obs.nix
    ../../../system/media/3d_print.nix
  ];

  hostSpec = {
    hostname = "home";
    users = [
      inputs.nix-secrets.users.profidev
      { username = "root"; }
    ];
  };
}
