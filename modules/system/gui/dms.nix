{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
  ];

  environment.systemPackages = with pkgs; [
    cosmic-files
  ];

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
