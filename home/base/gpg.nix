{ pkgs, userSpec, ... }:

{
  programs.gpg = {
    enable = true;

    publicKeys = [{
      text = userSpec.gpg_pub_key;
      trust = 5;
    }];
  };

  home.packages = with pkgs; [
    gnupg
  ];
}
