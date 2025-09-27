{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains-toolbox
    zed-editor
  ];
}
