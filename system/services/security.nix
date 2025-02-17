{ pkgs, inputs, ... }:

let
  keyring-unlocker = pkgs.stdenv.mkDerivation {
    name = "keyring-unlocker";
    src = (pkgs.fetchFromGitHub {
      owner = "recolic";
      repo = "gnome-keyring-yubikey-unlock";
      rev = "bc874e72e6f13b7385049fa4ea597dd8be6c72be";
      fetchSubmodules = true;
      hash = "sha256-SnmzUy+l4WtwYcpmZyWBeGjGJhtR91PQB3nDaOlaOkM=";
    });
    buildInputs = [ pkgs.git ];

    buildPhase = ''
      cd src
      sed -i 's|#include <iostream>|#include <iostream>\n#include <cstdint>|' lib/rlib/stdio.hpp
      make KEYRING_IMPL=standalone
      cd ..
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp bin/unlock_keyrings $out/bin
      cp unlock_keyrings.sh $out/bin
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
