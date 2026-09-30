{
  pkgs,
  inputs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    heroic
    #lutris
    r2modman
    wine
    winetricks
    gamemode

    #inputs.nix-citizen.packages.${stdenv.hostPlatform.system}.rsi-launcher
    proton-launcher
  ];
}
