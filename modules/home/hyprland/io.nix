{ hostSpec, ... }:

{
  wayland.windowManager.hyprland.settings = {
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

    monitorv2 = hostSpec.hyprlandMonitorConfig;
  };
}
