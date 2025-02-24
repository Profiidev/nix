{ pkgs, config, ... }:

{
  programs.gpg = {
    enable = true;

    publicKeys = [{
      text = config.userSpec.gpg_pub_key;
      trust = 5;
    }];
  };

  home.packages = with pkgs; [
    gnupg
  ];
}
