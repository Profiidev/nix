{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kora-icon-theme
  ];

  gtk = {
    enable = true;

    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Dark";
    };

    iconTheme = {
      package = pkgs.kora-icon-theme;
      name = "kora";
    };
  };

  dconf.enable = true;
  dconf.settings = {
    "org/gnome/calculator" = {
      accuracy = 9;
      base = 10;
      button-mode = "programming";
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [ "<Control><Alt>space" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Bibata-Modern-Ice";
      enable-animations = true;
      enable-hot-corners = false;
      gtk-theme = "Orchis-Dark";
      icon-theme = "kora";
      monospace-font-name = "FiraCode Nerd Font Mono 10";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
}
