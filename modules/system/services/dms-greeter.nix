{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
  ];

  environment.systemPackages = with pkgs; [
    greetd
    bibata-cursors
  ];

  services.displayManager.dms-greeter = {
    enable = true;
    compositor = {
      name = "hyprland";
      customConfig = ''
        input {
          kb_layout=de
          numlock_by_default=true
          accel_profile=flat

          touchpad {
            natural_scroll = true
            tap-to-click = true
            disable_while_typing = true
            clickfinger_behavior = true
          }
        }

        env = DMS_RUN_GREETER,1
        env = XCURSOR_PATH,/run/current-system/sw/share/icons
        env = XCURSOR_SIZE,24
        env = XCURSOR_THEME,Bibata-Modern-Ice

        misc {
          disable_hyprland_logo = true
          disable_splash_rendering = true
        }
      ''
      + config.hostSpec.hyprlandGreeterMonitorConfig;
    };

    configFiles = [
      "${pkgs.writeTextDir "settings.json" (builtins.readFile ../../../assets/dms.json)}/settings.json"
    ];

    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };
  };
}
