{ pkgs, isLinux, ... }:

{
  programs = (
    if isLinux then
      {
        nix-ld = {
          enable = true;
          libraries = with pkgs; [
            at-spi2-atk
            atkmm
            cairo
            gdk-pixbuf
            glib
            gtk3
            harfbuzz
            librsvg
            libsoup_3
            pango
            webkitgtk_4_1
            openssl
            stdenv.cc.cc.lib
            nss
            libclang.lib
            xorg.libX11
          ];
        };
      }
    else
      { }
  );
}
