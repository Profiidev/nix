{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    spotify
    wasistlos
    chromium
  ];
}
