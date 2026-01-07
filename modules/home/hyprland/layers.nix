{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    # Window Rules
    windowrule = [
      "rounding 12, border_size 0, match:class ^(org.gnome.)"
      "border_size 0, match:class ^(org.wezfurlong.wezterm)$"
      "border_size 0, match:class ^(Alacritty)$"
      "border_size 0, match:class ^(zen)$"
      "border_size 0, match:class ^(com.mitchellh.ghostty)$"
      "border_size 0, match:class ^(kitty)$"
      "float on, match:class ^(gnome-calculator)$"
      "float on, match:class ^(blueman-manager)$"
      "float on, match:class ^(org.gnome.Nautilus)$"
      "float on, match:class ^(org.quickshell)$"
    ];
  };
}
