{ pkgs, lib, userSpec, ... }:

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
}
