# Compositor-independent Wayland session base.
# Imported by both the hyprland and umbriel modules.
{ pkgs, ... }:

{
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    "_JAVA_AWT_WM_NONREPARENTING" = "1";
  };

  environment.systemPackages = with pkgs; [
    kitty
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    config.common.default = [ "gtk" ];
  };
}
