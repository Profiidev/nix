{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    teamspeak6-client
    spotify
  ];
}
