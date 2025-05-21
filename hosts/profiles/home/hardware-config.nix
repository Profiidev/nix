{ lib, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ata_piix"
    "ohci_pci"
    "ehci_pci"
    "nvme"
    "usbhid"
    "ahci"
    "sd_mod"
    "sr_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;
  networking.interfaces.enp6s0.wakeOnLan = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  fileSystems =
    builtins.listToAttrs (
      map
        (subvol: {
          name = "/mnt/arch${subvol.path}";
          value = {
            device = "/dev/disk/by-id/nvme-eui.00000000000000000026b7686223c485-part3";
            fsType = "btrfs";
            mountPoint = "/mnt/arch${subvol.path}";
            options = [
              "noatime"
              "compress=zstd"
              "space_cache=v2"
              "subvol=${subvol.name}"
            ];
          };
        })
        [
          {
            name = "/@";
            path = "";
          }
          {
            name = "/@home";
            path = "/home";
          }
          {
            name = "/@root";
            path = "/root";
          }
          {
            name = "/@srv";
            path = "/srv";
          }
          {
            name = "/@tmp";
            path = "/tmp";
          }
          {
            name = "/@cache";
            path = "/var/cache";
          }
          {
            name = "/@log";
            path = "/var/log";
          }
        ]
    )
    // {
      "/mnt/arch/boot/efi" = {
        device = "/dev/disk/by-id/nvme-eui.00000000000000000026b7686223c485-part1";
        fsType = "vfat";
        options = [ "relatime" ];
        mountPoint = "/mnt/arch/boot/efi";
      };
    }
    // {
      "/mnt/windows" = {
        device = "/dev/disk/by-id/nvme-KINGSTON_SKC2500M81000G_50026B768523BA97-part3";
        fsType = "ntfs";
        mountPoint = "/mnt/windows";
      };
    };
}
