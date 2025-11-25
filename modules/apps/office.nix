{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    teams-for-linux
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE
    freerdp
    inputs.winapps.packages."${stdenv.hostPlatform.system}".winapps
    inputs.winapps.packages."${stdenv.hostPlatform.system}".winapps-launcher
    #winboat
  ];
}
