{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
    heroic
    ferium
    lutris
    r2modman
    playonlinux
    r2modman
    wine
    wine64
    winetricks
    gamemode

    inputs.nix-citizen.packages.${system}.star-citizen-umu
    inputs.proton.packages.${system}.default
  ];

  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
  };

  programs.gamemode.enable = true;
}
