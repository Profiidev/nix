{
  pkgs,
  isLinux,
  lib,
  inputs,
  ...
}:

let
  system = pkgs.stdenv.hostPlatform.system;
in
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
      inputs.ags.packages.${system}.agsFull
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
