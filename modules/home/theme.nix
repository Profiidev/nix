{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kora-icon-theme
  ];
}
