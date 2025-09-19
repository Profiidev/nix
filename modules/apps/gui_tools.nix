{ pkgs, isLinux, ... }:

{
  environment.systemPackages = with pkgs; [
    dbeaver-bin
    postman
    wireshark
    drawio
    filezilla
    geary
    piper
    rpi-imager
    gimp
    vlc
    obsidian
    bitwarden-desktop
  ];

  services = (if isLinux then { ratbagd.enable = true; } else { });
}
