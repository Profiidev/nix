{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lan-mouse
  ];

  systemd.user.services.lan-mouse = {
    Unit = {
      Description = "Lan Mouse";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = with pkgs; {
      ExecStart = "${lan-mouse}/bin/lan-mouse daemon";
      Restart = "always";
      RestartSec = 5;
    };
  };
}
