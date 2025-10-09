{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
  ];

  programs.fish.enable = true;
}
