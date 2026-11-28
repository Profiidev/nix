{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    fluxer-canary-bin
    teamspeak6-client
    spotify
  ];
}
