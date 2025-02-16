{ userSpec, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";

    matchBlocks = userSpec.ssh_config;

    userKnownHostsFile =
      toString (pkgs.writeText "known_hosts" userSpec.ssh_known_hosts);
  };
}
