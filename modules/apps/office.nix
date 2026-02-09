{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    teams-for-linux
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    hunspellDicts.de_DE
    freerdp
    texliveFull
    tex-fmt
    inputs.affinity-nix.packages.${stdenv.hostPlatform.system}.v3
  ];
}
