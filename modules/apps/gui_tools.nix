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
      #wireshark
      drawio
      filezilla
      piper
      gimp
      vlc
      xkill
    ]
    ++ lib.optionals isLinux [
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
