{ pkgs, ... }:

let
  azure-cli = pkgs.azure-cli.withExtensions [ pkgs.azure-cli-extensions.account ];
in
{
  home.packages = [ azure-cli ];

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
      set -U fish_color_command blue
      export WEBKIT_DISABLE_COMPOSITING_MODE=1
      export RUSTC_WRAPPER=sccache
      export SCCACHE_CACHE_SIZE="50G"
      export PATH="$HOME/.cargo/bin:$PATH"
      export PATH="$HOME/go/bin:$PATH"
    '';
    
    interactiveShellInit = ''
      fastfetch
    '';

    shellAliases = {
      k = "kubectl";
      tf = "terraform";
      l = "eza -l -a --icons --group-directories-first";
      ls = "eza";
      nix-shell = "nix-shell --run fish";
      z = "zeditor";
    };

    plugins = [
      {
        name = "nvm";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "nvm.fish";
          rev = "abd3002b6d2d578d484a5aea94dd1517dded6d42";
          sha256 = "sha256-BNnoP9gLQuZQt/0SOOsZaYOexNN2K7PKWT/paS0BJJY=";
        };
      }
    ];
  };
}
