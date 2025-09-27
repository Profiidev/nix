{ ... }:

{
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  #services.displayManager.cosmic-greeter.enable = true;
  #services.desktopManager.cosmic.enable = true;
  #services.desktopManager.cosmic.xwayland.enable = true;

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
