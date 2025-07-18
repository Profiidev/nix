{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.clipboard-history
    gnomeExtensions.color-picker
    gnomeExtensions.dash-to-dock
    gnomeExtensions.forge
    gnomeExtensions.gsconnect
    gnomeExtensions.just-perfection
    gnomeExtensions.rounded-corners
    gnomeExtensions.search-light
    gnomeExtensions.vitals
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.hibernate-status-button
    gnomeExtensions.user-themes

    bibata-cursors
    orchis-theme
    kora-icon-theme
    whitesur-gtk-theme

    gnome-tweaks
    gnome-extension-manager
  ];

  gtk = {
    enable = true;
  };

  dconf.enable = true;
  dconf.settings = {
    "org/gnome/calculator" = {
      accuracy = 9;
      base = 10;
      button-mode = "programming";
    };

    "org/gnome/desktop/peripherals/keyboard" = {
      numlock-state = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [ "<Control><Alt>space" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Bibata-Modern-Ice";
      enable-animations = true;
      enable-hot-corners = false;
      gtk-theme = "Orchis-Dark";
      icon-theme = "kora";
      monospace-font-name = "FiraCode Nerd Font Mono 10";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "Vitals@CoreCoding.com"
        "another-window-session-manager@gmail.com"
        "clipboard-history@alexsaveau.dev"
        "dash-to-dock@micxgx.gmail.com"
        "just-perfection-desktop@just-perfection"
        "Rounded_Corners@lennart-k"
        "gsconnect@andyholmes.github.io"
        "color-picker@tuberry"
        "forge@jmmaranan.com"
        "search-light@icedman.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "hibernate-status@dromi"
      ];
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "firefox.desktop"
        "Alacritty.desktop"
        "dev.zed.Zed.desktop"
        "code.desktop"
      ];
      remember-mount-password = true;
      welcome-dialog-last-shown-version = "46.2";
    };

    "org/gnome/shell/extensions/clipboard-history" = {
      toggle-menu = [ "<Super>v" ];
      topbar-preview-size = 1;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      background-opacity = 0.8;
      dash-max-icon-size = 48;
      dock-position = "BOTTOM";
      height-fraction = 0.9;
      intellihide-mode = "ALL_WINDOWS";
      isolate-workspaces = true;
      multi-monitor = true;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "DP-3";
      show-icons-emblems = true;
      show-mounts = false;
      show-show-apps-button = false;
      show-trash = false;
    };

    "org/gnome/shell/extensions/forge" = {
      css-last-update = 37;
      css-updated = "1738328105514";
      focus-border-toggle = true;
      tiling-mode-enabled = false;
      window-gap-hidden-on-single = true;
      window-gap-size = 2;
      window-gap-size-increment = 1;
      workspace-skip-tile = "0";
    };

    "org/gnome/shell/extensions/gsconnect" = {
      devices = [ "30219ccb_da45_454c_9fd8_2676dde041f5" ];
      id = "2692b12a-e31a-4c59-b75c-1ecee742ebc2";
      name = "arch";
    };

    "org/gnome/shell/extensions/gsconnect/device/30219ccb_da45_454c_9fd8_2676dde041f5" = {
      certificate-pem = ''
        -----BEGIN CERTIFICATE-----
        MIIBkzCCATmgAwIBAgIBATAKBggqhkjOPQQDBDBTMS0wKwYDVQQDDCQzMDIxOWNj
        Yl9kYTQ1XzQ1NGNfOWZkOF8yNjc2ZGRlMDQxZjUxFDASBgNVBAsMC0tERSBDb25u
        ZWN0MQwwCgYDVQQKDANLREUwHhcNMjMwNzE2MjIwMDAwWhcNMzMwNzE2MjIwMDAw
        WjBTMS0wKwYDVQQDDCQzMDIxOWNjYl9kYTQ1XzQ1NGNfOWZkOF8yNjc2ZGRlMDQx
        ZjUxFDASBgNVBAsMC0tERSBDb25uZWN0MQwwCgYDVQQKDANLREUwWTATBgcqhkjO
        PQIBBggqhkjOPQMBBwNCAATYdx79uWSOkw4zU0Y5H2azj+N65NRFnGmaf9sT9IEb
        /zlaq+jc6jij6bQU5TuSLd3dW7UQZfpljhtiw7jlKrKnMAoGCCqGSM49BAMEA0gA
        MEUCIFHecxeUPJenmTXSjTpygD071fzxmc1XTP707WXpMjONAiEAyO2x3TXdPAwD
        rePto0+JNwlJOnbAQPtFUiFwWgD/R4I=
        -----END CERTIFICATE-----
      '';
      incoming-capabilities = [
        "kdeconnect.battery"
        "kdeconnect.bigscreen.stt"
        "kdeconnect.clipboard"
        "kdeconnect.clipboard.connect"
        "kdeconnect.contacts.request_all_uids_timestamps"
        "kdeconnect.contacts.request_vcards_by_uid"
        "kdeconnect.findmyphone.request"
        "kdeconnect.mousepad.keyboardstate"
        "kdeconnect.mousepad.request"
        "kdeconnect.mpris"
        "kdeconnect.mpris.request"
        "kdeconnect.notification"
        "kdeconnect.notification.action"
        "kdeconnect.notification.reply"
        "kdeconnect.notification.request"
        "kdeconnect.ping"
        "kdeconnect.runcommand"
        "kdeconnect.sftp.request"
        "kdeconnect.share.request"
        "kdeconnect.share.request.update"
        "kdeconnect.sms.request"
        "kdeconnect.sms.request_attachment"
        "kdeconnect.sms.request_conversation"
        "kdeconnect.sms.request_conversations"
        "kdeconnect.systemvolume"
        "kdeconnect.telephony.request"
        "kdeconnect.telephony.request_mute"
      ];
      last-connection = "lan://192.168.178.75:1716";
      name = "Pixel 8";
      outgoing-capabilities = [
        "kdeconnect.battery"
        "kdeconnect.bigscreen.stt"
        "kdeconnect.clipboard"
        "kdeconnect.clipboard.connect"
        "kdeconnect.connectivity_report"
        "kdeconnect.contacts.response_uids_timestamps"
        "kdeconnect.contacts.response_vcards"
        "kdeconnect.findmyphone.request"
        "kdeconnect.mousepad.echo"
        "kdeconnect.mousepad.keyboardstate"
        "kdeconnect.mousepad.request"
        "kdeconnect.mpris"
        "kdeconnect.mpris.request"
        "kdeconnect.notification"
        "kdeconnect.notification.request"
        "kdeconnect.ping"
        "kdeconnect.presenter"
        "kdeconnect.runcommand.request"
        "kdeconnect.sftp"
        "kdeconnect.share.request"
        "kdeconnect.sms.attachment_file"
        "kdeconnect.sms.messages"
        "kdeconnect.systemvolume.request"
        "kdeconnect.telephony"
      ];
      paired = true;
      supported-plugins = [
        "battery"
        "clipboard"
        "connectivity_report"
        "contacts"
        "findmyphone"
        "mousepad"
        "mpris"
        "notification"
        "ping"
        "presenter"
        "runcommand"
        "sftp"
        "share"
        "sms"
        "systemvolume"
        "telephony"
      ];
      type = "phone";
    };

    "org/gnome/shell/extensions/just-perfection" = {

    };

    "org/gnome/shell/extensions/lennart-k/rounded_corners" = {
      corner-radius = 15;
    };

    "org/gnome/shell/extensions/search-light" = {
      background-color = lib.hm.gvariant.mkTuple [
        0.0
        0.0
        0.0
        1.0
      ];
      blur-brightness = 0.6;
      blur-sigma = 30.0;
      border-radius = 1.8206278026905829;
      currency-converter = true;
      entry-font-size = 1;
      monitor-count = 2;
      popup-at-cursor-monitor = true;
      preferred-monitor = 0;
      scale-height = 0.4;
      scale-width = 0.4;
      shortcut-search = [ "<Alt>space" ];
      unit-converter = true;
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "WhiteSur-Dark";
    };

    "org/gnome/shell/extensions/vitals" = {
      fixed-widths = true;
      hot-sensors = [
        "_processor_usage_"
        "__temperature_avg__"
        "_memory_usage_"
        "_gpu#1_utilization_"
        "_temperature_gpu_"
        "_network-rx_enp6s0_rx_"
        "_network-tx_enp6s0_tx_"
      ];
      show-fan = false;
      show-gpu = true;
      show-storage = false;
      show-system = false;
      show-voltage = false;
    };

    "org/gnome/shell/extensions/Bluetooth-Battery-Meter" = {
      enable-battery-indicator-text = true;
      enable-battery-level-text = true;
      sort-devices-by-history = true;
      swap-icon-text = false;
    };

    "org/gnome/shell/extensions/hibernate-status-button" = {
      show-suspend = false;
      show-hybrid-sleep = false;
      show-suspend-then-hibernate = false;
    };

    "org/gnome/shell/keybindings" = {
      toggle-message-tray = [ "<Shift><Super>v" ];
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };
  };
}
