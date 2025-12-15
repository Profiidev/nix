{ lib, ... }:

{
  security.pam.services = {
    login.u2fAuth = true;
    gdm-password.u2fAuth = true;
    gdm-password.enableGnomeKeyring = true;
    sudo.u2fAuth = true;
  };

  security.pam.u2f = {
    enable = true;
    settings.cue = true;
  };

  services.pcscd.enable = true;

  security.polkit.extraConfig = ''
    polkit.addRule(function (action, subject) {
      if (
        (action.id == "org.freedesktop.login1.reboot" ||
         action.id == "org.freedesktop.login1.power-off" ||
         action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
         action.id == "org.freedesktop.login1.power-off-multiple-sessions") &&
        (subject.user == "ha_power")
      ) {
        return polkit.Result.YES;
      }
    });
  '';

  users.users.ha_power = {
    isNormalUser = true;
    createHome = lib.mkForce false;
    group = "ha_power";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKFTMajOlMBaHKWMnYsSyHRO0gC2BczCsIhlzwH3EFdP root@a0d7b954-ssh"
    ];
  };

  users.groups.ha_power = { };
  /*
    services.udev.extraRules = ''
      ACTION=="remove",\
       ENV{ID_BUS}=="usb",\
       ENV{ID_MODEL_ID}=="0407",\
       ENV{ID_VENDOR_ID}=="1050",\
       ENV{ID_VENDOR}=="Yubico",\
       RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
    '';
  */
}
