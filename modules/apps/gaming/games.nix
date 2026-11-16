{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    heroic
    r2modman
    wine
    winetricks
    gamemode

    proton-launcher
  ];
}
