{ pkgs, config, ... }:

{
  programs.gpg = {
    enable = true;

    publicKeys = [{
      text = config.userSpec.gpg_pub_key;
      trust = 5;
    }];
  };

  services.gpg-agent = {
    enable = true;

    extraConfig = ''
      allow-loopback-pinentry
    '';
  };

  home.packages = with pkgs; [ gnupg ];
}
