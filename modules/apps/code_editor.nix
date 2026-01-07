{ pkgs, isLinux, ... }:

{
  environment.systemPackages =
    with pkgs;
    [
      jetbrains-toolbox
      zed-editor
    ]
    ++ (
      if isLinux then
        [
          antigravity
          android-studio
        ]
      else
        [ ]
    );
}
