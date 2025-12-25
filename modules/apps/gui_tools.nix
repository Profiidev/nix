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
      geary
      piper
      gimp
      vlc
      obsidian
      xorg.xkill
      qjournalctl
    ]
    ++ lib.optionals isLinux [
      inputs.ags.packages.${system}.agsFull
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
