{ inputs, pkgs, ... }:

let
  hypr = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ inputs.hyprland.nixosModules.default ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;

    package = hypr.hyprland;
    portalPackage = hypr.xdg-desktop-portal-hyprland;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
  ];

  xdg.portal = {
    enable = true;

    config = {
      common = {
        default = [ "hyprland" ];
      };
    };
  };
}
