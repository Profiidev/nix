{ pkgsUnstableNoCuda, ... }:

{
  environment.systemPackages = with pkgsUnstableNoCuda; [
    orca-slicer
    #freecad
  ];
}
