{
  inputs,
  pkgs,
  config,
  ...
}:

let
  system = pkgs.stdenv.hostPlatform.system;
  vicinaeChromiumHost = pkgs.writeText "com.vicinae.vicinae.json" (
    builtins.toJSON {
      name = "com.vicinae.vicinae";
      description = "IPC Native Messaging Host";
      path = "${config.programs.vicinae.package}/libexec/vicinae/vicinae-browser-link";
      type = "stdio";
      allowed_origins = [
        "chrome-extension://kcmipingpfbohfjckomimmahknoddnke/"
      ];
    }
  );
in
{
  imports = [
    inputs.custom-nixpkgs.vicinae.homeManagerModules.default
  ];

  programs.vicinae = {
    enable = true;

    systemd = {
      enable = true;
      autoStart = true;
    };

    extensions = with inputs.custom-nixpkgs.vicinae-extensions.packages.${system}; [
      nix
      power-profile
      it-tools
      port-killer
      bluetooth
      #systemd
      hypr-keybinds
      vscode-recents
      zed-recents
      protondb-search
      jetbrains-recent-projects
      hyprland-monitors
      hypr
      timer
      npm
      pkgs.google-vicinae-extension
      pkgs.spotify-player-vicinae-extension
    ];
  };

  home.file.".config/vicinae/settings.json".source = ../../../assets/vicinae.json;

  xdg.configFile = {
    # Chromium / Brave / Vivaldi etc — add whichever browsers you use
    "chromium/NativeMessagingHosts/com.vicinae.vicinae.json".source = vicinaeChromiumHost;
    "google-chrome/NativeMessagingHosts/com.vicinae.vicinae.json".source = vicinaeChromiumHost;
    "BraveSoftware/Brave-Browser/NativeMessagingHosts/com.vicinae.vicinae.json".source =
      vicinaeChromiumHost;
  };

  home.packages = with pkgs; [
    sqlite
  ];

  wayland.windowManager.hyprland.extraConfig = builtins.readFile ../../../assets/hyprland/vicinae.lua;
}
