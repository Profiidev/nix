{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    spotify
    pear-desktop
    karere
    chromium
    rpi-imager
    teamspeak6-client
    blockbench
    zathura
  ];
}
