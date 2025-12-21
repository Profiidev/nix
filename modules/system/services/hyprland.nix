{ inputs, pkgs, ... }:

{
  imports = [ inputs.hyprland.nixosModules.default ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
  ];

  xdg.portal = {
    enable = true;
  };
}
