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
  home.file.".config/DankMaterialShell/settings.json".text = ''
    {
      "currentThemeName": "blue",
      "customThemeFile": "",
      "matugenScheme": "scheme-tonal-spot",
      "runUserMatugenTemplates": true,
      "matugenTargetMonitor": "",
      "popupTransparency": 1,
      "dockTransparency": 1,
      "widgetBackgroundColor": "sch",
      "widgetColorMode": "default",
      "cornerRadius": 12,
      "use24HourClock": true,
      "showSeconds": false,
      "useFahrenheit": false,
      "nightModeEnabled": false,
      "animationSpeed": 1,
      "customAnimationDuration": 500,
      "wallpaperFillMode": "Fill",
      "blurredWallpaperLayer": false,
      "blurWallpaperOnOverview": false,
      "showLauncherButton": true,
      "showWorkspaceSwitcher": true,
      "showFocusedWindow": true,
      "showWeather": true,
      "showMusic": true,
      "showClipboard": true,
      "showCpuUsage": true,
      "showMemUsage": true,
      "showCpuTemp": true,
      "showGpuTemp": true,
      "selectedGpuIndex": 0,
      "enabledGpuPciIds": [],
      "showSystemTray": true,
      "showClock": true,
      "showNotificationButton": true,
      "showBattery": true,
      "showControlCenterButton": true,
      "showCapsLockIndicator": true,
      "controlCenterShowNetworkIcon": true,
      "controlCenterShowBluetoothIcon": true,
      "controlCenterShowAudioIcon": true,
      "controlCenterShowVpnIcon": true,
      "controlCenterShowBrightnessIcon": false,
      "controlCenterShowMicIcon": false,
      "controlCenterShowBatteryIcon": false,
      "controlCenterShowPrinterIcon": false,
      "showPrivacyButton": true,
      "privacyShowMicIcon": false,
      "privacyShowCameraIcon": false,
      "privacyShowScreenShareIcon": false,
      "controlCenterWidgets": [
        {
          "id": "volumeSlider",
          "enabled": true,
          "width": 50
        },
        {
          "id": "brightnessSlider",
          "enabled": true,
          "width": 50
        },
        {
          "id": "wifi",
          "enabled": true,
          "width": 50
        },
        {
          "id": "bluetooth",
          "enabled": true,
          "width": 50
        },
        {
          "id": "audioOutput",
          "enabled": true,
          "width": 50
        },
        {
          "id": "audioInput",
          "enabled": true,
          "width": 50
        },
        {
          "id": "nightMode",
          "enabled": true,
          "width": 50
        },
        {
          "id": "darkMode",
          "enabled": true,
          "width": 50
        }
      ],
      "showWorkspaceIndex": false,
      "showWorkspacePadding": false,
      "workspaceScrolling": false,
      "showWorkspaceApps": false,
      "maxWorkspaceIcons": 3,
      "workspacesPerMonitor": true,
      "showOccupiedWorkspacesOnly": false,
      "dwlShowAllTags": false,
      "workspaceNameIcons": {},
      "waveProgressEnabled": true,
      "scrollTitleEnabled": true,
      "clockCompactMode": false,
      "focusedWindowCompactMode": false,
      "runningAppsCompactMode": true,
      "keyboardLayoutNameCompactMode": false,
      "runningAppsCurrentWorkspace": false,
      "runningAppsGroupByApp": false,
      "centeringMode": "index",
      "clockDateFormat": "ddd d MMM yyyy",
      "lockDateFormat": "ddd d MMM yyyy",
      "mediaSize": 1,
      "appLauncherViewMode": "list",
      "spotlightModalViewMode": "list",
      "sortAppsAlphabetically": false,
      "appLauncherGridColumns": 4,
      "spotlightCloseNiriOverview": true,
      "niriOverviewOverlayEnabled": true,
      "weatherLocation": "Bad Aibling, 83043",
      "weatherCoordinates": "47.8640504,12.0097685",
      "useAutoLocation": false,
      "weatherEnabled": true,
      "networkPreference": "auto",
      "vpnLastConnected": "0c3a064f-ff59-4485-8eff-f0ae36f23fe2",
      "iconTheme": "System Default",
      "launcherLogoMode": "apps",
      "launcherLogoCustomPath": "",
      "launcherLogoColorOverride": "",
      "launcherLogoColorInvertOnMode": false,
      "launcherLogoBrightness": 0.5,
      "launcherLogoContrast": 1,
      "launcherLogoSizeOffset": 0,
      "fontFamily": "Inter Variable",
      "monoFontFamily": "Fira Code",
      "fontWeight": 400,
      "fontScale": 1,
      "notepadUseMonospace": true,
      "notepadFontFamily": "",
      "notepadFontSize": 14,
      "notepadShowLineNumbers": false,
      "notepadTransparencyOverride": -1,
      "notepadLastCustomTransparency": 0.7,
      "soundsEnabled": true,
      "useSystemSoundTheme": false,
      "soundNewNotification": true,
      "soundVolumeChanged": true,
      "soundPluggedIn": true,
      "acMonitorTimeout": 0,
      "acLockTimeout": 0,
      "acSuspendTimeout": 0,
      "acSuspendBehavior": 0,
      "acProfileName": "",
      "batteryMonitorTimeout": 0,
      "batteryLockTimeout": 0,
      "batterySuspendTimeout": 0,
      "batterySuspendBehavior": 0,
      "batteryProfileName": "",
      "lockBeforeSuspend": true,
      "loginctlLockIntegration": true,
      "fadeToLockEnabled": true,
      "fadeToLockGracePeriod": 5,
      "launchPrefix": "",
      "brightnessDevicePins": {},
      "wifiNetworkPins": {},
      "bluetoothDevicePins": {},
      "audioInputDevicePins": {},
      "audioOutputDevicePins": {},
      "gtkThemingEnabled": false,
      "qtThemingEnabled": false,
      "syncModeWithPortal": true,
      "terminalsAlwaysDark": false,
      "showDock": true,
      "dockAutoHide": true,
      "dockGroupByApp": true,
      "dockOpenOnOverview": false,
      "dockPosition": 1,
      "dockSpacing": 8,
      "dockBottomGap": 0,
      "dockMargin": 0,
      "dockIconSize": 40,
      "dockIndicatorStyle": "circle",
      "dockBorderEnabled": false,
      "dockBorderColor": "secondary",
      "dockBorderOpacity": 1,
      "dockBorderThickness": 1,
      "notificationOverlayEnabled": false,
      "modalDarkenBackground": true,
      "lockScreenShowPowerActions": true,
      "enableFprint": false,
      "maxFprintTries": 15,
      "lockScreenActiveMonitor": "DP-1",
      "lockScreenInactiveColor": "#000000",
      "hideBrightnessSlider": false,
      "notificationTimeoutLow": 5000,
      "notificationTimeoutNormal": 5000,
      "notificationTimeoutCritical": 0,
      "notificationPopupPosition": 0,
      "osdAlwaysShowValue": false,
      "osdPosition": 5,
      "osdVolumeEnabled": true,
      "osdMediaVolumeEnabled": true,
      "osdBrightnessEnabled": true,
      "osdIdleInhibitorEnabled": true,
      "osdMicMuteEnabled": true,
      "osdCapsLockEnabled": true,
      "osdPowerProfileEnabled": true,
      "osdAudioOutputEnabled": true,
      "powerActionConfirm": true,
      "powerActionHoldDuration": 0.5,
      "powerMenuActions": [
        "reboot",
        "logout",
        "poweroff",
        "lock",
        "suspend",
        "restart"
      ],
      "powerMenuDefaultAction": "logout",
      "powerMenuGridLayout": false,
      "customPowerActionLock": "",
      "customPowerActionLogout": "",
      "customPowerActionSuspend": "",
      "customPowerActionHibernate": "",
      "customPowerActionReboot": "",
      "customPowerActionPowerOff": "",
      "updaterUseCustomCommand": false,
      "updaterCustomCommand": "",
      "updaterTerminalAdditionalParams": "",
      "displayNameMode": "system",
      "screenPreferences": {},
      "showOnLastDisplay": {},
      "barConfigs": [
        {
          "id": "default",
          "name": "Main Bar",
          "enabled": true,
          "position": 0,
          "screenPreferences": [
            "all"
          ],
          "showOnLastDisplay": true,
          "leftWidgets": [
            "launcherButton",
            "workspaceSwitcher",
            "focusedWindow"
          ],
          "centerWidgets": [
            "music",
            "clock",
            "weather"
          ],
          "rightWidgets": [
            {
              "id": "privacyIndicator",
              "enabled": true
            },
            {
              "id": "systemTray",
              "enabled": true
            },
            {
              "id": "cpuUsage",
              "enabled": true
            },
            {
              "id": "memUsage",
              "enabled": true
            },
            {
              "id": "vpn",
              "enabled": true
            },
            {
              "id": "idleInhibitor",
              "enabled": true
            },
            {
              "id": "notepadButton",
              "enabled": true
            },
            {
              "id": "colorPicker",
              "enabled": true
            },
            {
              "id": "notificationButton",
              "enabled": true
            },
            {
              "id": "controlCenterButton",
              "enabled": true
            }
          ],
          "spacing": 4,
          "innerPadding": 4,
          "bottomGap": 0,
          "transparency": 1,
          "widgetTransparency": 1,
          "squareCorners": false,
          "noBackground": false,
          "gothCornersEnabled": false,
          "gothCornerRadiusOverride": false,
          "gothCornerRadiusValue": 12,
          "borderEnabled": false,
          "borderColor": "surfaceText",
          "borderOpacity": 1,
          "borderThickness": 1,
          "widgetOutlineEnabled": false,
          "widgetOutlineColor": "primary",
          "widgetOutlineOpacity": 1,
          "widgetOutlineThickness": 1,
          "fontScale": 1,
          "autoHide": false,
          "autoHideDelay": 250,
          "openOnOverview": false,
          "visible": true,
          "popupGapsAuto": true,
          "popupGapsManual": 4,
          "maximizeDetection": true
        }
      ],
      "configVersion": 2
    }
  '';
}
