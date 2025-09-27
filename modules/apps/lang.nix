{ pkgs, isLinux, ... }:

{
  environment.systemPackages =
    with pkgs;
    [
      # CC
      gcc
      gnumake
      cmake
      autoconf
      automake
      libtool
      # Python setup
      python313
      imath
      pystring
      uv
      # Rust
      rustup
      # Go
      go
      # Java
      jdk23
    ]
    ++ (
      if isLinux then
        (with pkgs; [
          # Android
          android-tools
          android-udev-rules
        ])
      else
        [ ]
    );
}
