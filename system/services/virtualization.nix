{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    virt-manager
    distrobox
    libvirt
    virt-manager
    qemu
    uefi-run
    lxc
    swtpm
    bottles
  ];

  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
    };
  };
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];
  virtualisation.libvirtd = {
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    enable = true;
    qemu.runAsRoot = false;
  };
  virtualisation.waydroid.enable = true;

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];
}
