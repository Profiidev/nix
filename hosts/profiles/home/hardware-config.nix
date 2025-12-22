{ lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disk-config.nix
  ];

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
  boot.kernelModules = [
    "kvm-intel"
    "sg"
  ];
  boot.extraModulePackages = [ ];
  hardware.cpu.intel.updateMicrocode = true;

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;
  networking.interfaces.enp6s0.wakeOnLan.enable = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  fileSystems = {
    "/mnt/windows" = {
      device = "/dev/disk/by-id/nvme-KINGSTON_SKC2500M81000G_50026B768523BA97-part3";
      fsType = "ntfs";
      mountPoint = "/mnt/windows";
    };
  };

  hostSpec.hyprlandGreeterMonitorConfig = ''
    monitorv2 {
      output=DP-1
      mode=2560x1440@165Hz
      position=0x0
    }

    monitorv2 {
      output=HDMI-A-1
      mode=1920x1080@60Hz
      position=2560x0
    }
  '';

  hostSpec.hyprlandMonitorConfig = [
    {
      output = "DP-1";
      mode = "2560x1440@165Hz";
      position = "0x0";
    }
    {
      output = "HDMI-A-1";
      mode = "1920x1080@60Hz";
      position = "2560x0";
    }
  ];
}
