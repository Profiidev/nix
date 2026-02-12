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
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  #boot.resumeDevice = "/dev/disk/by-uuid/bcd05679-815e-4c95-bc12-a20a8195c7b6";
  #boot.kernelParams = [ "resume_offset=533760" ];
  hardware.cpu.intel.updateMicrocode = true;

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
