{ ... }:

{
  wayland.windowManager.hyprland.extraConfig = builtins.readFile ../../../assets/hyprland/dms.lua;

  home.file.".config/DankMaterialShell/settings.json".source = ../../../assets/shells/dms.json;
  home.file.".local/state/DankMaterialShell/session.json".source =
    ../../../assets/shells/dms-session.json;
}
