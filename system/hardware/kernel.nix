{ config, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.consoleLogLevel = 0;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ata_piix" "ohci_pci" "ehci_pci" "nvme" "usbhid" "ahci" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
}