{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    cinny-desktop
    spotify
    karere
    chromium
    rpi-imager
    teamspeak6-client
    blockbench
    zathura
  ];
}
