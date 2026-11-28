{ inputs, pkgs, ... }:

{
  imports = [
    inputs.custom-nixpkgs.umbriel.nixosModules.default
    ./desktop.nix
  ];

  programs.umbriel = {
    enable = true;
    package = pkgs.umbriel;
    portalPackage = pkgs.xdg-desktop-portal-umbriel;
  };
}
