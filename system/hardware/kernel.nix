{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.consoleLogLevel = 0;

  boot.initrd = {
    systemd.enable = true;
  };

  services.logind = {
    lidSwitch = "hibernate";
    lidSwitchDocked = "hibernate";
    lidSwitchExternalPower = "hibernate";
  };

  consoleLogLevel = 3;
  initrd.verbose = false;
  kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "udev.log_priority=3"
    "rd.systemd.show_status=auto"
  ];
}
