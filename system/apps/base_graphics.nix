{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    btrfs-assistant
    btrfs-heatmap
    drawio
    filezilla
    geary
    piper
    spotify
    wasistlos
    ungoogled-chromium
  ];
}
