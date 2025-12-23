{
  inputs,
  pkgs,
  ...
}:

let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  services.vicinae = {
    enable = true;
    autoStart = true;

    extensions = with inputs.vicinae-extensions.packages.${system}; [
      bluetooth
      nix
      power-profile
      it-tools
      port-killer
      vicinaeSpotify
      vicinaeVsCode
      vicinaeGoogle
      pkgs.google-vicinae-extension
      pkgs.spotify-player-vicinae-extension
      pkgs.vscode-recent-projects-vicinae-extension
    ];
  };

  home.file.".config/vicinae/settings.json".source = ../../../assets/vicinae.json;

  home.packages = with pkgs; [
    sqlite
  ];

  wayland.windowManager.hyprland.settings = {
    # Layer Rules
    layerrule = [
      "no_anim on, match:namespace ^(vicinae)$"
    ];
  };
}
