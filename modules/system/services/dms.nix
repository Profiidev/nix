{ ... }:

{
  imports = [
    ./hyprland.nix
  ];

  services.displayManager.dms-greeter = {
    enable = true;
    compositor = {
      name = "hyprland";
      customConfig = ''
        input {
          kb_layout=de
        }
      '';
    };

    configHome = "/home/profidev";

    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };
  };

  programs.dms-shell = {
    enable = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    enableVPN = true;
    enableSystemMonitoring = true;
    enableDynamicTheming = true;
    enableClipboard = true;
    enableCalendarEvents = true;
    enableAudioWavelength = true;
  };

  programs.dsearch = {
    enable = true;
    systemd.enable = true;
  };

  systemd.user.targets.hyprland-session = {
    description = "Hyprland Session Target";
    requires = [
      "graphical-session.target"
    ];
    after = [
      "graphical-session.target"
    ];
  };

  systemd.user.services.dms = {
    wantedBy = [
      "hyprland-session.target"
    ];
    wants = [
      "hyprland-session.target"
    ];
    after = [
      "hyprland-session.target"
    ];
  };
}
