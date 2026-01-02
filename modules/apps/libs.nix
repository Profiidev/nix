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
            linuxKernel.packages.linux_6_18.nvidia_x11.lib32

            # bevy
            alsa-lib-with-plugins
            vulkan-loader
            xorg.libX11
            xorg.libXcursor
            xorg.libXrandr
            xorg.libXi
            libxkbcommon
            libudev-zero
            udev
            wayland.dev
          ];
        };
      }
    else
      { }
  );
}
