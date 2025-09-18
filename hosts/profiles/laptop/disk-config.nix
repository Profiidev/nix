{ ... }:
{
  imports = [
    ../../disks/btrfs-luks.nix
    {
      _module.args = {
        disk = "/dev/disk/by-id/nvme-PCIe-8_SSD_1TB_YMA11T0JA2133004AD";
        withSwap = true;
        swapSize = 16;
      };
    }
  ];
}
