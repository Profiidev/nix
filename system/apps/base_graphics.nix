{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    btrfs-assistant
    btrfs-heatmap
    drawio
    filezilla
    geary
    piper
    spotify
    wasistlos
    dbeaver-bin
#    chromium
    pkgs.callPackage ./custom/shanocast.nix
  ];
}
