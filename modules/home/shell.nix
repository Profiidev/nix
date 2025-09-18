{ pkgs, ... }:

let
in
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
      nix-shell = "nix-shell --run fish";
      k = "kubectl";
      tf = "terraform";
      ls = "eza";
      z = "zeditor";
      g = "git";
    };

    shellAbbrs = {
      l = "eza -l -a --icons --group-directories-first";
      gco = "git checkout";
      gcom = "git checkout main";
      gcob = "git checkout -b";
      gb = "git branch";
      gbd = "git branch -d";
      gbD = "git branch -D";
      gcm = "git commit -m";
      gca = "git commit --amend --no-edit";
      gcae = "git commit --amend";
      gpl = "git pull";
      gps = "git push";
      gpsu = "git push --set-upstream origin";
      ga = "git add";
      gaa = "git add -A";
      grao = "git remote add origin";
      c = "cargo";
      cb = "cargo build";
      cr = "cargo run";
      cbr = "cargo build --release";
      crr = "cargo run --release";
      rmf = "rm -rf";
      dco = "docker compose up";
      clr = "clear";
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
      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          sha256 = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        };
      }
      {
        name = "abbr-tips";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fish-abbreviation-tips";
          rev = "8ed76a62bb044ba4ad8e3e6832640178880df485";
          sha256 = "sha256-F1t81VliD+v6WEWqj1c1ehFBXzqLyumx5vV46s/FZRU=";
        };
      }
    ];
  };
}
