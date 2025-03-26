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
    kubectl
    kustomize
    kubernetes-helm
    helm-ls
    helmfile
    kubernetes-helmPlugins.helm-diff
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    at-spi2-atk
    atkmm
    cairo
    gdk-pixbuf
    glib
    gtk3
    harfbuzz
    librsvg
    libsoup_3
    pango
    webkitgtk_4_1
    openssl
  ];

  documentation.man.generateCaches = false;
}
