{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Android
    android-tools
    android-udev-rules
    # CC
    gcc
    gnumake
    cmake
    autoconf
    automake
    libtool
    # Python setup
    python3Full
    imath
    pystring
    # Rust
    rustup
    # Nix
    nil
    nixfmt-rfc-style
    # Cache
    sccache
  ];
}
