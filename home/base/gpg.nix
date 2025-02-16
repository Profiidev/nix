{ userSpec, config, ... }:

{
  programs.gpg = {
    enable = true;

    publicKeys = [{
      source = config.sops.secrets."gpg_keys/${userSpec.username}".path;
      trust = 5;
    }];
  };
}
