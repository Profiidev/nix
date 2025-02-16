{ lib, ... }:

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
    ../../../system/profiles/coding.nix
    ../../../system/profiles/gaming.nix

    # Extra
    ../../../system/media/obs.nix
  ];

  hostSpec = {
    username = "profidev";
    hostname = "home";
    ssh_keys = [
      "ed25519_sk"
    ];
  };
}