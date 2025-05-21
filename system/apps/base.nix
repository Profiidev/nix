{ pkgs, ... }:

let
  wrapped-kubernetes-helm = with pkgs; wrapHelm kubernetes-helm {
    plugins = with pkgs.kubernetes-helmPlugins; [
      helm-secrets
      helm-diff
      helm-s3
      helm-git
    ];
  };

  wrapped-helmfile = pkgs.helmfile-wrapped.override {
    inherit (wrapped-kubernetes-helm) pluginsDir;
  };
in
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
    helm-ls
    wrapped-helmfile
    wrapped-kubernetes-helm
    # Nix
    nil
    nixfmt-rfc-style
    ssh-to-age
    yq-go
    age
    pciutils
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

  fonts.packages = with pkgs; [
    nerd-fonts.fira-mono
    nerd-fonts.fira-code
  ];
}
