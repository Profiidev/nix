{ ... }:

{
  imports = [
    ../base/browser.nix
    ../base/fastfetch.nix
    ../base/git.nix
    ../base/shell.nix
    ../base/sops.nix
    ../base/ssh.nix
    ../base/starship.nix
    ../base/terminal.nix
    ../base/zoxide.nix
  ];

  programs.home-manager.enable = true;
}
