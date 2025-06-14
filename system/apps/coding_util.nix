{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    act
    docker
    docker-buildx
    docker-compose
    kdePackages.kcachegrind
    maven
    nvidia-container-toolkit
    ollama
    valgrind
    linuxKernel.packages.linux_zen.perf
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
    espflash
    release-plz
    sea-orm-cli
    trunk
    wasm-pack
    pkg-config
    gobject-introspection
    terraform
    minikube
    uv
    devenv
    jdk23
    azure-cli
    go
  ];

  programs.direnv = {
    silent = true;
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
    loadInNixShell = true;
  };
}
