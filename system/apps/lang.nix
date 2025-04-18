{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
    # Cache
    sccache
  ];
}
