{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    massif-visualizer
    renderdoc
    perf
    valgrind
    kdePackages.kcachegrind
  ];
}
