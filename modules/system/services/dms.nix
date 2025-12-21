{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
  ];

  environment.systemPackages = with pkgs; [
    cosmic-files
    greetd
  ];

  services.displayManager.dms-greeter = {
    enable = true;
    compositor = {
      name = "hyprland";
      customConfig = ''
        input {
          kb_layout=de
          numlock_by_default=true
        }

        env = DMS_RUN_GREETER,1
        env = XCURSOR_SIZE,24
        env = XCURSOR_THEME,Bibata-Modern-Ice

        misc {
          disable_hyprland_logo = true
          disable_splash_rendering = true
        }

        monitorv2 {
          output=DP-1
          mode=2560x1440@165Hz
          position=0x0
        }

        monitorv2 {
          output=HDMI-A-1
          mode=1920x1080@60Hz
          position=2560x0
        }
      '';
    };

    configFiles = [
      ../../home/dms.json
    ];

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

    plugins = {
      DankBatteryAlerts = {
        src = "${
          pkgs.fetchFromGitHub {
            owner = "AvengeMedia";
            repo = "dms-plugins";
            rev = "8fa7c5286171c66a209dd74e9a47d6e72ccfdad6";
            sha256 = "sha256-0RXRgUXXoX+C0q+drsShjx2rCTdmqFzOCR/1rGB/W2E=";
          }
        }/DankBatteryAlerts";
      };
    };
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

  networking.networkmanager = {
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
  };
}
