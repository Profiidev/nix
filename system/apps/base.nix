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
    nerd-fonts.fira-mono
    nerd-fonts.fira-code
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
    pam_u2f
    libfido2
    sops
    openssl
    arp-scan
    cmatrix
    neo-cowsay
    efitools
    efibootmgr
    git-cliff
    haskellPackages.hashable
    htop
    inetutils
    nettools
    ntfs3g
    sbctl
    speedtest-cli
    tealdeer
    traceroute
    waypipe
    whois
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  ];
}
