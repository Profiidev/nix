{ lib, inputs, ... }:

{
  imports = lib.flatten [
    (../../disks/btrfs-luks.nix)
    {
      _module.args = {
        disk = "/dev/disk/by-id/nvme-PCIe-8_SSD_1TB_YMA11T0JA2133004AD";
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
    hostname = "laptop";
    users = [ inputs.nix-secrets.users.profidev { username = "root"; } ];
  };
}
