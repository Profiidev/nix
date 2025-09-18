{ pkgs, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    theme = pkgs.nixos-grub2-theme;
    efiSupport = true;
    font = "${pkgs.nixos-grub2-theme}/dejavu.pf2";
  };

  boot.plymouth.enable = true;

  environment.systemPackages = with pkgs; [
    efitools
    efibootmgr
    ntfs3g
    sbctl
  ];
}
