{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (inputs.noctalia.packages.${stdenv.hostPlatform.system}.default.override {
      calendarSupport = true;
    })
    gpu-screen-recorder
    nemo-with-extensions
  ];

  imports = [
    ./hyprland.nix
  ];

  programs.gpu-screen-recorder.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.gnome.evolution-data-server.enable = true;
}
