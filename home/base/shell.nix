{ ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      exec fish
    '';
  };

  programs.fish = {
    enable = true;
    generateCompletions = true;

    shellInit = ''
      set fish_greeting
      export WEBKIT_DISABLE_COMPOSITING_MODE=1
      export RUSTC_WRAPPER=/home/profidev/.cargo/bin/sccache
      export SCCACHE_CACHE_SIZE="50G"
      export PATH="$HOME/.cargo/bin:$PATH"
      export PATH="$HOME/go/bin:$PATH"
    '';
    shellInitLast = ''
      fastfetch
    '';

    shellAliases = { k = "kubectl"; };
  };
}
