{ ... }:

# mac user
{
  imports = [
    ../../modules/profiles/home/base.nix
    ../../modules/home/terminal.nix
    ../../modules/home/nix.nix
  ];
}
