{ lib, inputs, ... }:

{
  imports = lib.flatten [
    inputs.nix-secrets.profidev

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

  hostSpec = { hostname = "home"; };
}
