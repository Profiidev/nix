{ inputs, pkgs, ... }:

{
  imports = [ inputs.custom-nixpkgs.hyprland.nixosModules.default ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;

    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
  ];

  environment.sessionVariables = {
    "_JAVA_AWT_WM_NONREPARENTING" = "1";
  };

  xdg.portal = {
    enable = true;

    config = {
      common = {
        default = [ "hyprland" ];
      };
    };
  };
}
