{ ... }:

{
  imports = [
    ../base/apps.nix
    ../base/browser.nix
    ../base/fastfetch.nix
    ../base/git.nix
    ../base/gnome.nix
    ../base/shell.nix
    ../base/sops.nix
    ../base/ssh.nix
    ../base/starship.nix
    ../base/terminal.nix
    ../base/wallpaper.nix
    ../base/zoxide.nix
  ];

  programs.home-manager.enable = true;
}
