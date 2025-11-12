{ pkgs, isLinux, ... }:

{
  environment.systemPackages = with pkgs; [
    dbeaver-bin
    postman
    insomnia
    wireshark
    drawio
    filezilla
    geary
    piper
    gimp
    vlc
    obsidian
    bitwarden-desktop
    xorg.xkill
    qjournalctl
  ];

  services = (
    if isLinux then
      {
        ratbagd.enable = true;
      }
    else
      { }
  );
}
