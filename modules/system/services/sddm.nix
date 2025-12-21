{ pkgs, ... }:

{
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

  environment.systemPackages = with pkgs; [
    bibata-cursors
  ];
}
