{ ... }:

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
/*
  services.udev.extraRules = ''
    ACTION=="remove",\
     ENV{ID_BUS}=="usb",\
     ENV{ID_MODEL_ID}=="0407",\
     ENV{ID_VENDOR_ID}=="1050",\
     ENV{ID_VENDOR}=="Yubico",\
     RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';*/
}
