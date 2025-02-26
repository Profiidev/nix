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
  ];
}