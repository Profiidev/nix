{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    spotify
    wasistlos
    chromium
    rpi-imager
    teamspeak6-client
    blockbench
  ];
}
