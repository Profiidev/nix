{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    alacritty
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      window.dimensions = {
        columns = 130;
        lines = 32;
      };

      font.normal = {
        family = "FiraCode Nerd Font Mono";
        style = "Regular";
      };

      colors = {
        primary = {
          background = "#0A0E14";
          foreground = "#ffffff";
        };

        normal = {
          black = "#171421";
          red = "#c01c28";
          green = "#26a269";
          yellow = "#a2734c";
          blue = "#12488b";
          magenta = "#a347ba";
          cyan = "#2aa1b3";
          white = "#d0cfcc";
        };

        bright = {
          black = "#5e5c64";
          red = "#f66151";
          green = "#33d17a";
          yellow = "#e9ad0c";
          blue = "#2a7bde";
          magenta = "#c061cb";
          cyan = "#33c7de";
          white = "#ffffff";
        };
      };
    };
  };
}