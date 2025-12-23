{ ... }:

{
  wayland.windowManager.hyprland.settings = {
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
  };
}
