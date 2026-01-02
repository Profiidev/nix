{ ... }:

{
  imports = [
    ../../system/hardware/cooling.nix
    ../../system/hardware/no-sleep.nix
    ../../system/hardware/nvidia.nix

    ../../system/services/nix-serve.nix
  ];
}
