{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    massif-visualizer
    renderdoc
    linuxKernel.packages.linux_zen.perf
    valgrind
    kdePackages.kcachegrind
  ];
}
