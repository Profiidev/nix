{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    badlion-client
    ferium
    heroic
    lutris
    #minecraft
    modrinth-app
    playonlinux
    r2modman
    wine
    wine64
    winetricks
  ];
}
