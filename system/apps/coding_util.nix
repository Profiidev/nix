{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    act
    age
    docker
    docker-buildx
    docker-compose
    kubernetes-helm
    helm-ls
    helmfile
    kdePackages.kcachegrind
    kubectl
    kustomize
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
    espflash
    release-plz
    sea-orm-cli
    trunk
    wasm-pack
  ];
}