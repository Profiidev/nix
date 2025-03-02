{ lib, inputs, ... }:

{
  imports = lib.flatten [
    (../../disks/btrfs-luks.nix)
    {
      _module.args = {
        disk = "/dev/disk/by-id/<id>";
        withSwap = true;
        swapSize = 16;
      };
    }

    ./hardware-config.nix

    ../../spec.nix

    # Profiles
    ../../../system/profiles/base.nix
    ../../../system/profiles/graphics.nix
    ../../../system/profiles/laptop.nix
  ];

  hostSpec = {
    hostname = "home";
    users = [ inputs.nix-secrets.users.profidev { username = "root"; } ];
  };
}
