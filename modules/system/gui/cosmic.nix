{ pkgs, ... }:

{
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  services.desktopManager.cosmic.xwayland.enable = true;

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

  services.ringboard.wayland.enable = true;
}
