{ pkgs, inputs, ... }:

let
  keyring-unlocker = pkgs.stdenv.mkDerivation {
    name = "keyring-unlocker";
    src = inputs.keyring-unlocker-src;
    phases = [ "installPhase" ];

    installPhase = ''
      cd $src
      git submodule update --init --recursive
      cd src
      make
      make KEYRING_IMPL=standalone
      mkdir -p $out/bin
      cp $src/bin/unlock_keyrings $out/bin
      cp $src/unlock_keyrings.sh $out/bin
    '';
  };
in {
  environment.systemPackages = [ keyring-unlocker ];

  security.pam.services = {
    login.u2fAuth = true;
    gdm-password.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  services.udev.extraRules = ''
    ACTION=="remove",\
     ENV{ID_BUS}=="usb",\
     ENV{ID_MODEL_ID}=="0407",\
     ENV{ID_VENDOR_ID}=="1050",\
     ENV{ID_VENDOR}=="Yubico",\
     RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';
}
