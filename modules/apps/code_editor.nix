{ pkgs, pkgsUnstable, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains-toolbox
    pkgsUnstable.zed-editor
  ];
}
