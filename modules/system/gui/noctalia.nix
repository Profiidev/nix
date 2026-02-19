{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (inputs.noctalia.packages.${stdenv.hostPlatform.system}.default.override {
      calendarSupport = true;
    })
    gpu-screen-recorder
    nemo-with-extensions
    kdePackages.qttools
  ];

  imports = [
    ./hyprland.nix
  ];

  # kde connect
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  programs.gpu-screen-recorder.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.gnome.evolution-data-server.enable = true;
}
