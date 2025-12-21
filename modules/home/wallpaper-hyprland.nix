{ pkgs, ... }:

let
  script = pkgs.writeScriptBin "wallpaper.sh" ''
    #!/usr/bin/env bash
    wget https://profidev.io/backend/services/apod/random -O wallpaper.png

    pwd=$(pwd)

    swww img $pwd/wallpaper.png --transition-type fade --transition-duration 0 --resize crop
  '';
in
{
  systemd.user.services.auto-wallpaper = {
    Unit = {
      Description = "Auto Wallpaper Changer";
      After = [ "swww.service" ];
    };

    Service = {
      ExecStart = "${script}/bin/wallpaper.sh";
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };

  services.swww.enable = true;
}
