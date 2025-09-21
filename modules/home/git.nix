{ pkgs, config, ... }:

{
  home.packages = with pkgs; [ git ];

  programs.git = {
    enable = true;
    userName = config.userSpec.git_user;
    userEmail = config.userSpec.git_email;

    aliases = {
      a = "add";
      aa = "add -A";
      cm = "commit -m";
      com = "checkout main";
      b = "branch";
      bd = "branch -d";
      bdd = "branch -D";
      pl = "pull";
      ps = "push";
      psu = "push --set-upstream origin";
      co = "checkout";
      cob = "checkout -b";
      rao = "remote add origin";
      mm = "merge main --no-edit";
      mme = "merge main";
    };

    extraConfig = {
      pull = {
        rebase = true;
      };

      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_${config.userSpec.git_sign_key}.pub";

      push = {
        autoSetupRemote = true;
        followTags = true;
        recurseSubmodules = "on-demand";
      };

      rebase = {
        autoStash = true;
      };

      init = {
        defaultBranch = "main";
      };

      submodule = {
        recurse = true;
      };
    };
  };
}
