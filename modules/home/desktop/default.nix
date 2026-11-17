# Compositor-independent desktop: shell, apps and user services.
# Imported by both the hyprland and umbriel modules.
{ pkgs, ... }:

{
  imports = [
    ./aurora.nix
    ./corona.nix
    ./positron.nix
  ];

  home.packages = with pkgs; [
    wtype
  ];
}
