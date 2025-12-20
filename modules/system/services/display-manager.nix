{ pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  #services.displayManager.gdm.enable = true;
  #services.desktopManager.gnome.enable = true;

  # Cosmic
  #services.displayManager.cosmic-greeter.enable = true;
  #services.desktopManager.cosmic.enable = true;
  #services.desktopManager.cosmic.xwayland.enable = true;

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.displayManager.sddm = {
    enable = true;
    theme = "${pkgs.sddm-theme}/share/sddm/themes/clean";
    extraPackages = with pkgs; [
      kdePackages.qt5compat
    ];
  };
  services.xserver = {
    enable = true;
    displayManager.setupCommands = ''
      # DP-1 as primary and HDMI-A-1 as secondary display (to the right) off
      /run/current-system/sw/bin/xrandr --output DP-0 --auto --primary
      /run/current-system/sw/bin/xrandr --output HDMI-0 --off
    '';
  };

  environment.systemPackages = with pkgs; [
    cosmic-reader
    cosmic-ext-ctl
    cosmic-ext-tweaks
    cosmic-ext-applet-emoji-selector
    cosmic-ext-applet-privacy-indicator
    cosmic-ext-applet-minimon
    andromeda
    cosmic-ext-applet-ollama
    gui-scale-applet
    clipboard-history-cosmic-applet
    bibata-cursors
  ];

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = "1";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  services.ringboard.wayland.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
