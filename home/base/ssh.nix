{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";

    matchBlocks = config.userSpec.ssh_config;

    userKnownHostsFile =
      toString (pkgs.writeText "known_hosts" config.userSpec.ssh_known_hosts);
  };
}
