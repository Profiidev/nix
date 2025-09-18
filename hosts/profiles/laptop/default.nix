{ inputs, ... }:

{
  imports = [
    ./hardware-config.nix

    ../../spec.nix

    # Profiles
    ../../../system/profiles/base.nix
    ../../../system/profiles/graphics.nix
    ../../../system/profiles/coding_graphics.nix
    ../../../system/profiles/laptop.nix
    ../../../system/profiles/office.nix
  ];

  hostSpec = {
    hostname = "laptop";
    users = [
      inputs.nix-secrets.users.profidev
      { username = "root"; }
    ];
  };
}
