{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
    heroic
    badlion-client
    ferium
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
