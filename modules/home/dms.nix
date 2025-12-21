{ ... }:

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
        inactive_opacity = 0.9;

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
        "$mod, TAB, exec, dms ipc call hypr toggleOverview"

        # Security
        "$mod, L, exec, dms ipc call lock lock"
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
      ];

      input = {
        kb_layout = "de";
      };

      monitorv2 = [
        {
          output = "DP-1";
          mode = "2560x1440@165Hz";
          position = "0x0";
        }
        {
          output = "HDMI-A-1";
          mode = "1920x1080@60Hz";
          position = "2560x0";
        }
      ];
    };
  };

  # write dms config to .config/DankMaterialShell/settings.json
  #home.file.".config/DankMaterialShell/settings.json".text = ''
  #'';
}
