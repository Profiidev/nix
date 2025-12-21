{ config, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    systemd.enable = false;
    package = null;
    portalPackage = null;

    settings = {
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user start hyprland-session.target"
        "bash -c \"wl-paste --watch cliphist store &\""
      ];

      # Miscellaneous
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      # Environment
      env = [
        "QT_QPA_PLATFORM,wayland"
        "ELECTRON_OYONE_PLATFORM_HINT,auto"
        "QT_QPA_PLATFORMTHEME,gtk3"
        "QT_QPA_PLATFORMTHEME_QT6,gtk3"
      ];

      # General
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 0;
        "col.active_border" = "rgba(707070ff)";
        "col.inactive_border" = "rgba(d0d0d0ff)";
        layout = "dwindle";
      };

      # Decoration
      decoration = {
        rounding = 12;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 30;
          render_power = 5;
          offset = "0 5";
          color = "rgba(00000070)";
        };
      };

      # Layer Rules
      layerrule = [
        "no_anim on, match:namespace ^(dms)$"
      ];

      # Window Rules
      windowrulev2 = [
        "opacity 0.9 0.9, floating:0, focus:0"
        "rounding 12, class:^(org\.gnome\.)"
        "noborder, class:^(org\.gnome\.)"
        "noborder, class:^(org\.wezfurlong\.wezterm)$"
        "noborder, class:^(Alacritty)$"
        "noborder, class:^(zen)$"
        "noborder, class:^(com\.mitchellh\.ghostty)$"
        "noborder, class:^(kitty)$"
        "float, class:^(gnome-calculator)$"
        "float, class:^(blueman-manager)$"
        "float, class:^(org\.gnome\.Nautilus)$"
        "float, class:^(org.quickshell)$"
      ];

      # Keybindings
      "$mod" = "SUPER";

      bind = [
        # Application Launchers
        "ALT, space, exec, dms ipc call spotlight toggle"
        "$mod, V, exec, dms ipc call clipboard toggle"
        "$mod, M, exec, dms ipc call processlist focusOrToggle"
        "$mod, comma, exec, dms ipc call settings focusOrToggle"
        "$mod, N, exec, dms ipc call notifications toggle"
        "$mod, Y, exec, dms ipc call dankdash wallpaper"
        "$mod SHIFT, S, exec, dms screenshot"
        "$mod, TAB, exec, dms ipc call hypr toggleOverview"
        "ALT, T, exec, alacritty"
        "$mod, Q, killactive"
        "$mod, F, togglefloating"
        "ALT, F, fullscreen, 1"
        "$mod, I, togglesplit"

        # Move Focus
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
        "$mod, left, movefocus, l"
        "$mod, down, movefocus, d"
        "$mod, up, movefocus, u"
        "$mod, right, movefocus, r"

        # Move Window
        "ALT, H, movewindow, l"
        "ALT, J, movewindow, d"
        "ALT, K, movewindow, u"
        "ALT, L, movewindow, r"
        "ALT, left, movewindow, l"
        "ALT, down, movewindow, d"
        "ALT, up, movewindow, u"
        "ALT, right, movewindow, r"

        # Switch Workspace
        "ALT, 1, workspace, 1"
        "ALT, 2, workspace, 2"
        "ALT, 3, workspace, 3"
        "ALT, 4, workspace, 4"
        "ALT, 5, workspace, 5"
        "ALT, 6, workspace, 6"
        "ALT, 7, workspace, 7"
        "ALT, 8, workspace, 8"
        "ALT, 9, workspace, 9"
        "ALT, 0, workspace, 10"

        # move active window to workspace
        "ALT SHIFT, 1, movetoworkspace, 1"
        "ALT SHIFT, 2, movetoworkspace, 2"
        "ALT SHIFT, 3, movetoworkspace, 3"
        "ALT SHIFT, 4, movetoworkspace, 4"
        "ALT SHIFT, 5, movetoworkspace, 5"
        "ALT SHIFT, 6, movetoworkspace, 6"
        "ALT SHIFT, 7, movetoworkspace, 7"
        "ALT SHIFT, 8, movetoworkspace, 8"
        "ALT SHIFT, 9, movetoworkspace, 9"
        "ALT SHIFT, 0, movetoworkspace, 10"

        # scroll through workspaces
        "ALT, mouse_down, workspace, e+1"
        "ALT, mouse_up, workspace, e-1"

        # special workspaces
        "ALT, E, togglespecialworkspace, magic-e"
        "ALT SHIFT, E, movetoworkspace, special:magic-e"
        "ALT, D, togglespecialworkspace, magic-d"
        "ALT SHIFT, D, movetoworkspace, special:magic-d"

        # Security
        "CONTROL, L, exec, dms ipc call lock lock"
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

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      input = {
        kb_layout = "de";
        numlock_by_default = true;
        accel_profile = "flat";
        sensitivity = 0.4;

        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
        };
      };

      monitorv2 = config.hostSpec.hyprlandMonitorConfig;
    };
  };

  home.file.".config/DankMaterialShell/settings.json".source = ./dms.json;
}
