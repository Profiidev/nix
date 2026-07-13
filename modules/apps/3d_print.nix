{ pkgs, pkgsUnstableNoCuda, ... }:

{
  environment.systemPackages = with pkgs; [
    cura-appimage
    #freecad
  ];
}
