{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nano
    os-prober
    home-manager
    ripgrep
    curl
    wget
    fd
    dust
    fzf
    jq
    neofetch
    tree
    unzip
    unrar
    xdg-utils
    zip
    nerdfonts
    discord
    gh
    nmap
    man-pages
    man-pages-posix
    drawio
    coreutils
    neovim
    just
    rsync
  ];
}