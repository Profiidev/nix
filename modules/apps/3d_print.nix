{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cura-appimage
    #pkgsUnstableNoCuda.freecad
  ];
}
