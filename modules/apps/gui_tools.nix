{
  pkgs,
  isLinux,
  lib,
  ...
}:

{
  environment.systemPackages =
    with pkgs;
    [
      dbeaver-bin
      postman
      insomnia
      wireshark
      drawio
      filezilla
      piper
      gimp
      vlc
      obsidian
      xkill
      qjournalctl
    ]
    ++ lib.optionals isLinux [
      deskflow
      wl-clipboard
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
