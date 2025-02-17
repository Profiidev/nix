{ pkgs, ... }:

{
  xdg.autostart = {
    enable = true;
    entries = [ "${pkgs.evolution}/share/applications/wallpaper.desktop" ];
  };

  xdg.desktopEntries = {
    wallpaper = {
      name = "Wallpaper";
      exec = toString (pkgs.writeScriptBin "wallpaper.sh" ''
        #!/bin/bash
        wget https://profidev.io/backend/services/apod/random -O wallpaper.png

        pwd=$(pwd)

        gsettings set org.gnome.desktop.background picture-uri-dark $pwd/wallpaper.png
      '');
      terminal = false;
      noDisplay = true;
    };
  };
}
