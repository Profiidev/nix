{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
    heroic
    badlion-client
    ferium
    lutris
    r2modman
    prismlauncher
    modrinth-app
    playonlinux
    r2modman
    wine
    wine64
    winetricks

    inputs.nix-citizen.packages.${system}.star-citizen-umu
  ];

  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
  };
}
