{ ... }:

{
  imports = [
    ../apps/lang.nix
    ../apps/coding_util.nix

    ../media/blender.nix

    ../services/docker.nix
    ../services/virtualization.nix
  ];
}
