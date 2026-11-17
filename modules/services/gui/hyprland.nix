{
  pkgs,
  config,
  ...
}:

{
  imports = [
    ./desktop.nix
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;

    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  services.hypridle.enable = true;

  environment.pathsToLink = [
    "/share/hypr"
  ];

  xdg.portal = {
    extraPortals = with pkgs; [
      config.programs.hyprland.portalPackage
      hypr-kdeconnect-fix
    ];

    config.Hyprland = {
      default = [
        "hyprland"
        "gtk"
      ];
      "org.freedesktop.impl.portal.ScreenCast" = [
        "hyprland"
      ];
      "org.freedesktop.impl.portal.Screenshot" = [
        "hyprland"
      ];
      "org.freedesktop.impl.portal.GlobalShortcuts" = [
        "hyprland"
      ];
      "org.freedesktop.impl.portal.RemoteDesktop" = [
        "hypr-kdeconnect"
      ];
    };
  };
}
