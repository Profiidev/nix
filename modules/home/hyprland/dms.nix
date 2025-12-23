{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Application Launchers
      "$mod, M, exec, dms ipc call processlist focusOrToggle"
      "$mod, comma, exec, dms ipc call settings focusOrToggle"
      "$mod SHIFT, S, exec, dms screenshot"
      "$mod, TAB, exec, dms ipc call hypr toggleOverview"

      # Security
      "ALT, L, exec, dms ipc call lock lock"
    ];

    # Repeatable and Locked binds
    bindel = [
      ", XF86AudioRaiseVolume, exec, dms ipc call audio increment 3"
      ", XF86AudioLowerVolume, exec, dms ipc call audio decrement 3"
      ", XF86MonBrightnessUp, exec, dms ipc call brightness increment 5"
      ", XF86MonBrightnessDown, exec, dms ipc call brightness decrement 5"
    ];

    bindl = [
      ", XF86AudioMute, exec, dms ipc call audio mute"
      ", XF86AudioMicMute, exec, dms ipc call audio micmute"
      ", XF86AudioNext, exec, dms ipc call mpris next"
      ", XF86AudioPrev, exec, dms ipc call mpris previous"
      ", XF86AudioPlay, exec, dms ipc call mpris playPause"
      ", XF86AudioPause, exec, dms ipc call mpris pause"
    ];
  };

  home.file.".config/DankMaterialShell/settings.json".source = ../../../assets/dms.json;
}
