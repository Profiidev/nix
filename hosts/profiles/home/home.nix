{ ... }:

{
  imports = [
    ../../../system/apps/browser.nix
    ../../../system/apps/git.nix
    ../../../system/apps/lang.nix
    ../../../system/apps/terminal.nix
    ./sops.nix
  ];

  programs.home-manager.enable = true;
}