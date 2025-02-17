{ pkgs, ... }:

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

    plugins = [{
      name = "nvm";
      src = pkgs.fetchFromGitHub {
        owner = "jorgebucaran";
        repo = "nvm.fish";
        rev = "abd3002b6d2d578d484a5aea94dd1517dded6d42";
        sha256 = "sha256-BNnoP9gLQuZQt/0SOOsZaYOexNN2K7PKWT/paS0BJJY=";
      };
    }];
  };
}
