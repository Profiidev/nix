{
  inputs,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    inputs.custom-nixpkgs.corona.homeModules.default
  ];

  home.packages = with pkgs; [
    sshfs
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = lib.mkForce "qt6ct";
    GTK_THEME = "adw-gtk3";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "adw-gtk3";
      color-scheme = "prefer-dark";
    };
  };

  services.hyprpolkitagent.enable = true;
  services.kdeconnect.enable = true;

  wayland.windowManager.hyprland.extraConfig = builtins.readFile ../../../assets/hyprland/corona.lua;

  programs.corona = {
    enable = true;

    toolkits.enable = true;

    settings =
      lib.recursiveUpdate (fromTOML (builtins.readFile ../../../assets/shells/corona-settings.toml))
        {
          shell = {
            avatar = ../../../assets/images/profidev.jpeg;
          };
          theme.sync_toolkits = true;
        };
  };

  home.activation = {
    deleteOldCoronaSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      rm -f "$HOME/.local/state/corona/settings.toml"
    '';
  };
}
