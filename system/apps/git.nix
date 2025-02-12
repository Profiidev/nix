{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;
    userName = "ProfiiDev";
    userEmail = "92174452+Profiidev@users.noreply.github.com";
    aliases = {
      a = "add";
      aa = "add -A";
      cm = "commit -m";
      com = "checkout master";
      b = "branch";
      bd = "branch -d";
      bdd = "branch -D";
      pl = "pull";
      ps = "push";
      psu = "push --set-upstream origin";
      co = "checkout";
      cob = "checkout -b";
      rao = "remote add origin";
    };
    extraConfig = {
      pull = {
        rebase = true;
      };
      commit = {
        gpgsign = true;
      };
    };
  };
}