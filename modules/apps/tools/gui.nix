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
      filezilla
      xkill
      zathura
      rpi-imager
    ]
    ++ lib.optionals isLinux [
      wl-clipboard
      claude-desktop
    ];

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
}
