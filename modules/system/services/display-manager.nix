{ pkgs, ... }:

{
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.displayManager.gdm.enable = true;
  #services.desktopManager.gnome.enable = true;

  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  services.desktopManager.cosmic.xwayland.enable = true;

  environment.systemPackages = with pkgs; [
    cosmic-ext-applet-clipboard-manager
    cosmic-ext-tweaks
    cosmic-ext-applet-external-monitor-brightness
    cosmic-ext-applet-emoji-selector
    andromeda
    minimon-applet
  ];

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = "1";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
