{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cargo-binstall
    cargo-dist
    cargo-expand
    cargo-generate
    cargo-llvm-cov
    cargo-make
    cargo-nextest
    cargo-release
    cargo-semver-checks
    cargo-tauri
    cargo-watch
    cargo-bootimage
    trunk
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
    zip
    coreutils
    just
    rsync
    cmatrix
    neo-cowsay
    git-cliff
    htop
    inetutils
    nettools
    speedtest-cli
    tealdeer
    traceroute
    waypipe
    whois
    ssh-to-age
    yq-go
    age
    pciutils
    nss
    libcef
    openssl
    bat
    eza
    xh
    hyperfine
    tokei
    dig
    nmap
    neovim
    openssl
    arp-scan
    man-pages
    man-pages-posix
    ollama
    sops
    pam_u2f
    libfido2
    haskellPackages.hashable
  ];

  programs.direnv = {
    silent = true;
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
    loadInNixShell = true;
  };

  documentation.man.generateCaches = false;
}
