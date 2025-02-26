{ lib, inputs, ... }:

{
  imports = lib.flatten [
    (../../disks/btrfs-luks.nix)
    {
      _module.args = {
        disk = "/dev/sda";
        withSwap = true;
        swapSize = 4;
      };
    }

    ./hardware-config.nix

    ../../spec.nix

    # Profiles
    ../../../system/profiles/base.nix
    ../../../system/profiles/coding_graphics.nix
    ../../../system/profiles/coding.nix
    ../../../system/profiles/gaming.nix
    ../../../system/profiles/graphics.nix

    # Extra
    ../../../system/media/obs.nix
    ../../../system/media/3d_print.nix
  ];

  hostSpec = {
    hostname = "home";
    users = [ inputs.nix-secrets.users.profidev { username = "root"; } ];
  };
}
