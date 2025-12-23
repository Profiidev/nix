{ ... }:

{
  wayland.windowManager.hyprland.settings = {
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
  };
}
