{
  pkgs,
  isLinux,
  ...
}:

{
  environment.systemPackages =
    with pkgs;
    [
      cargo-binstall
      cargo-dist
      cargo-expand
      cargo-generate
      cargo-make
      cargo-nextest
      cargo-release
      cargo-semver-checks
      cargo-tauri
      cargo-watch
      cargo-bootimage
      trunk
      nano
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
      zip
      coreutils
      just
      rsync
      cmatrix
      neo-cowsay
      git-cliff
      htop
      btop
      inetutils
      nettools
      speedtest-cli
      tealdeer
      whois
      ssh-to-age
      yq-go
      age
      pciutils
      nss
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
      sops
      pam_u2f
      libfido2
      haskellPackages.hashable
      cachix
      fish
      dioxus-cli
    ]
    ++ (
      if isLinux then
        (with pkgs; [
          cargo-llvm-cov
          os-prober
          traceroute
          waypipe
          libcef
        ])
      else
        [ ]
    );

  programs.direnv = {
    silent = true;
    enable = true;
    nix-direnv.enable = true;
    loadInNixShell = true;
  }
  // (
    if isLinux then
      {
        enableFishIntegration = true;
      }
    else
      { }
  );

  documentation = (
    if isLinux then
      {
        man.generateCaches = false;
      }
    else
      { }
  );
}
