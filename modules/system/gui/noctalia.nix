{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      calendarSupport = true;
    })
  ];

  imports = [
    ./hyprland.nix
  ];

  programs.gpu-screen-recorder.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.gnome.evolution-data-server.enable = true;
}
