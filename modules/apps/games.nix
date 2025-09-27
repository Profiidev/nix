{
  pkgs,
  inputs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
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

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    protontricks.enable = true;
  };
}
