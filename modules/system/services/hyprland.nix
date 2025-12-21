{ inputs, pkgs, ... }:

{
  imports = [ inputs.hyprland.nixosModules.default ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.displayManager.sddm = {
    enable = true;
    theme = "${pkgs.sddm-theme}/share/sddm/themes/clean";
    extraPackages = with pkgs; [
      kdePackages.qt5compat
      bibata-cursors
    ];
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 24;
      };
    };
  };

  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    bibata-cursors
    kitty
  ];

  xdg.portal = {
    enable = true;
  };
}
