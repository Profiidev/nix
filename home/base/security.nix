{ pkgs, lib, userSpec, ... }:

{
  home.packages = with pkgs; [ yubikey-manager ];

  home.file.".config/Yubico/u2f_keys".text = userSpec.login_key;

  home.activation.createYubicoDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/.config/Yubico
  '';
}
