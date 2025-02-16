{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nano
    os-prober
    home-manager
    ripgrep



    coreutils
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
    blender
    gimp
    obs-studio
    neovim
    vlc
    obsidian
  ];
}