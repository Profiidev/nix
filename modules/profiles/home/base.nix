{ ... }:

{
  imports = [
    ../../home/fastfetch.nix
    ../../home/git.nix
    ../../home/gpg.nix
    ../../home/security.nix
    ../../home/shell.nix
    ../../home/sops.nix
    ../../home/ssh.nix
    ../../home/starship.nix
    ../../home/zoxide.nix
  ];

  programs.home-manager.enable = true;
}
