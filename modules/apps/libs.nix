{ pkgs, config, isLinux, ... }:

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
            config.boot.kernelPackages.nvidia_x11.lib32

            # bevy
            alsa-lib-with-plugins
            vulkan-loader
            libx11
            libxcursor
            libxi
            libxrandr
            libxkbcommon
            libudev-zero
            udev
            wayland.dev
            libgcc.lib
            zlib
            zstd
            curl
            stdenv.cc.cc
            bzip2
            libxml2
            acl
            libsodium
            util-linux
            xz
            systemd
          ];
        };
      }
    else
      { }
  );
}
