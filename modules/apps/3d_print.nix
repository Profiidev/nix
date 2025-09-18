{ pkgs, pkgsUnstable, ... }:

{
  environment.systemPackages = with pkgs; [
    cura-appimage
    pkgsUnstable.freecad
  ];
}
