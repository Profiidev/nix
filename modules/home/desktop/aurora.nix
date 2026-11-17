{ inputs, pkgs, ... }:

{
  imports = [
    inputs.custom-nixpkgs.aurora.homeModules.default
  ];

  programs.aurora = {
    enable = true;
    package = pkgs.aurora;
  };
}
