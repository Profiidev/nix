{ ... }:

# mac user
{
  targets.darwin = {
    linkApps.enable = true;
    copyApps.enable = false;
  };

  imports = [
    ../../modules/profiles/home/base.nix
    ../../modules/home/terminal.nix
    ../../modules/home/nix.nix
  ];
}
