{ pkgs, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    theme = pkgs.nixos-grub2-theme;
    efiSupport = true;
  };

  boot.plymouth.enable = true;
}
