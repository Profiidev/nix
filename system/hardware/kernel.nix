{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.consoleLogLevel = 0;

  boot.initrd = {
    systemd.enable = true;
  };
}
