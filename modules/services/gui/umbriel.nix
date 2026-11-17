{ inputs, pkgs, ... }:

{
  imports = [
    inputs.custom-nixpkgs.umbriel.nixosModules.default
  ];

  programs.umbriel = {
    enable = true;
    package = pkgs.umbriel;
  };
}
