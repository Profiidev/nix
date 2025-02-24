{ ... }:

{
  imports = [
    ../base/fastfetch.nix
    ../base/git.nix
    ../base/gpg.nix
    ../base/nh.nix
    ../base/security.nix
    ../base/shell.nix
    ../base/sops.nix
    ../base/ssh.nix
    ../base/starship.nix
    ../base/zoxide.nix
  ];

  programs.home-manager.enable = true;
}
