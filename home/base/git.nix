{ pkgs, hostSpec, ... }:

{
  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;
    userName = hostSpec.git_user;
    userEmail = hostSpec.git_email;

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

      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/${builtins.elemAt hostSpec.ssh_keys 0}.pub";
    };
  };
}