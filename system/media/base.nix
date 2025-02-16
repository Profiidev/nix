{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ gimp vlc obsidian ];
}
