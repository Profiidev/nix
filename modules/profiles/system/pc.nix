{ ... }:

{
  imports = [
    ../../system/hardware/no-sleep.nix
    ../../system/hardware/nvidia.nix

    ../../system/services/nix-serve.nix
  ];
}
