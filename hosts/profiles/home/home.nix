{ ... }:

{
  imports = [
    ../../../system/apps/browser.nix
    ../../../system/apps/git.nix
    ../../../system/apps/lang.nix
    ../../../system/apps/ssh.nix
    ../../../system/apps/terminal.nix
  ];

  programs.home-manager.enable = true;
}