{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "*" = {
        userKnownHostsFile = toString (pkgs.writeText "known_hosts" config.userSpec.ssh_known_hosts);
        addKeysToAgent = "yes";
      };
    }
    // config.userSpec.ssh_config;
  };
}
