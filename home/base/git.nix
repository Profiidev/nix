{ pkgs, userSpec, ... }:

{
  home.packages = with pkgs; [ git ];

  programs.git = {
    enable = true;
    userName = userSpec.git_user;
    userEmail = userSpec.git_email;

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
      pull = { rebase = true; };

      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_${userSpec.git_sign_key}.pub";
    };
  };
}
