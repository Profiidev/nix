{ pkgs, config, ... }:

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
      sed -i 's|bin/unlock_keyrings|unlock_keyrings|' unlock_keyrings.sh
      sed -i 's|/bin/bash|/usr/bin/env bash|' unlock_keyrings.sh
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
  home.packages = with pkgs; [
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui

    keyring-unlocker
  ];

  systemd.user.services.unlock-keyring = {
    Unit = {
      Description = "Unlocks Keyring";
      BindsTo = "gnome-session.target";
    };

    Service = {
      Type = "oneshot";
      EnvironmentFile = "${config.sops.templates."yubikey_pin".path}";
      ExecStart = ''
        ${keyring-unlocker}/bin/unlock_keyrings.sh ${
          config.sops.secrets."keyring_keys/${config.userSpec.username}".path
        } ''${PIN}'';
    };

    Install = { WantedBy = [ "gnome-session.target" ]; };
  };
}
