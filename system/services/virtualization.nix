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
  virtualisation.libvirtd = {
    allowedBridges = [ "nm-bridge" "virbr0" ];
    enable = true;
    qemu.runAsRoot = false;
  };
  virtualisation.waydroid.enable = true;
}
