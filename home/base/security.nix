{ pkgs, lib, userSpec, config, ... }:

{
  home.packages = with pkgs; [
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui
  ];

  home.file.".config/Yubico/u2f_keys".text = userSpec.login_key;

  home.activation.createYubicoDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/.config/Yubico
  '';

  systemd.user.services.unlock-keyring = {
    Unit = {
      Description = "Unlocks Keyring";
      BindsTo = "gnome-session.target";
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.keyring-unlocker}/bin/unlock-keyring.sh ${
          config.sops.secrets."keyring_keys/${userSpec.username}".path
        } ${config.sops.secrets."yubikey_pins/${userSpec.username}"}";
    };

    Install = { WantedBy = [ "gnome-session.target" ]; };
  };
}
