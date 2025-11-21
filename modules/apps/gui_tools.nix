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
