{
  pkgs,
  isLinux,
  ...
}:

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
      jdk25
      # Dart
      dart
      flutter
      gradle
    ]
    ++ (
      if isLinux then
        (with pkgs; [
          # Android
          android-tools
          sdkmanager
          virtualgl
        ])
      else
        [ ]
    );
}
// (
  if isLinux then
    {
      programs.adb.enable = true;
    }
  else
    { }
)
