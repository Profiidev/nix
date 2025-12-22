{ pkgs, inputs, lib, ... }:

{
  imports = [ inputs.silentSDDM.nixosModules.default ];

  programs.silentSDDM = {
    enable = true;
    theme = "catppuccin-mocha";
    profileIcons = {
      profidev = ../../../assets/profidev.jpeg;
    };
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = lib.mkForce true;
    enableHidpi = true;
    extraPackages = with pkgs; [
      bibata-cursors
    ];
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 24;
      };
    };
  };

  environment.variables = {
    XCURSOR_SIZE = "24";
    XCURSOR_THEME = "Bibata-Modern-Ice";
  };
}
