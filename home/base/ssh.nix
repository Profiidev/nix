{ userSpec, ... }:

{
  programs.ssh = {
    enable = true;
    addKeysToAgent = true;

    matchBlocks = userSpec.ssh_config;
  };
}
