{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    positron
  ];

  systemd.user.services.positron = {
    Unit = {
      Description = "Positron";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = with pkgs; {
      ExecStart = "${positron}/bin/positron";
      Restart = "always";
      RestartSec = 5;
    };
  };

  wayland.windowManager.hyprland.extraConfig = builtins.readFile ../../../assets/hyprland/positron.lua;
}
