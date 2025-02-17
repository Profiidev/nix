{ pkgs, ... }:

let
  script = pkgs.writeScriptBin "wallpaper.sh" ''
    #!/bin/bash
    wget https://profidev.io/backend/services/apod/random -O wallpaper.png

    pwd=$(pwd)

    gsettings set org.gnome.desktop.background picture-uri-dark $pwd/wallpaper.png
  '';

  desktop = pkgs.writeTextFile {
    name = "wallpaper.desktop";
    test = ''
      [Desktop Entry]
        Type=Application
        Name=Wallpaper
        Exec=${script}/bin/wallpaper.sh
        Terminal=false
        NoDisplay=true
        X-GNOME-Autostart-enabled=true
    '';
  };
in {
  xdg.autostart = {
    enable = true;

    entries = [ desktop ];
  };
}
