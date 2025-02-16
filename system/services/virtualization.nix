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
    guest = {
      enable = true;
      dragAndDrop = true;
    };
  };
  virtualisation.libvirtd = {
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    enable = true;
    qemu.runAsRoot = false;
  };
  virtualisation.waydroid.enable = true;
}