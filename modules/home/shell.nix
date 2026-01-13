{ pkgs, isLinux, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      if [[ $- == *i* ]]; then
        exec fish
      fi
    '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    initContent = ''
      if [[ $- == *i* ]]; then
        exec fish
      fi
    '';
  };

  home.sessionVariables = {
    RUSTC_WRAPPER = "sccache";
    SCCACHE_CACHE_SIZE = "50G";
    LIBVIRT_DEFAULT_URI = "qemu:///system";
    LIBCLANG_PATH = "/run/current-system/sw/share/nix-ld/lib";
  }
  // (
    if isLinux then
      {
        CPATH = "${pkgs.glibc.dev}/include:$CPATH";
        CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome-stable";
      }
    else
      { }
  );
}
