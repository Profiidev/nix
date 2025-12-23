{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    # Keybindings
    "$mod" = "SUPER";

    bind = [
      # Application Launchers
      "ALT, space, exec, vicinae toggle"
      "$mod, space, exec, vicinae toggle"
      "$mod, V, exec, vicinae deeplink vicinae://extensions/vicinae/clipboard/history"
      "$mod, T, exec, alacritty"
      "$mod, B, exec, brave"
      "$mod, Q, killactive"
      "ALT, F, togglefloating"
      "$mod, F, fullscreen, 1"
      "$mod, I, togglesplit"

      # Move Focus
      "ALT, H, movefocus, l"
      "ALT, J, movefocus, d"
      "ALT, K, movefocus, u"
      "ALT, L, movefocus, r"
      "ALT, left, movefocus, l"
      "ALT, down, movefocus, d"
      "ALT, up, movefocus, u"
      "ALT, right, movefocus, r"

      # Move Window
      "$mod, H, movewindow, l"
      "$mod, J, movewindow, d"
      "$mod, K, movewindow, u"
      "$mod, L, movewindow, r"
      "$mod, left, movewindow, l"
      "$mod, down, movewindow, d"
      "$mod, up, movewindow, u"
      "$mod, right, movewindow, r"

      # Switch Workspace
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      # move active window to workspace
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"

      # scroll through workspaces
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"

      # special workspaces
      "$mod, E, togglespecialworkspace, magic-e"
      "$mod SHIFT, E, movetoworkspace, special:magic-e"
      "$mod, D, togglespecialworkspace, magic-d"
      "$mod SHIFT, D, movetoworkspace, special:magic-d"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
