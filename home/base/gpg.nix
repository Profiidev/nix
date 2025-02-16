{ hostSpec, config, ... }:

{
  programs.gpg = {
    enable = true;

    publicKeys = [{
      source = config.sops.secrets."gpg_keys/${hostSpec.username}".path;
      trust = 5;
    }];
  };
}
