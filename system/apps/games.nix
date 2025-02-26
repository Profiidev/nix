{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    badlion-client
    ferium
    heroic
    lutris
    prismlauncher
    modrinth-app
    playonlinux
    r2modman
    wine
    wine64
    winetricks
  ];
}
