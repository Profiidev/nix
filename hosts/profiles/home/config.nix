{ lib, inputs, ... }:

{
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops

    (../../disks/btrfs-luks.nix) 
    {
      _module.args = {
        disk = "/dev/sda";
        withSwap = true;
        swapSize = 4;
      };
    }

    ./hardware-config.nix

    ../../spec.nix

    ../../../system/general.nix
    ../../../system/sops.nix
    ../../../system/locale.nix
    ../../../system/user.nix

    ../../../system/apps/base.nix
    ../../../system/apps/flatpak.nix
    ../../../system/apps/gamemode.nix
    ../../../system/apps/steam.nix

    ../../../system/hardware/bluetooth.nix
    ../../../system/hardware/boot.nix
    ../../../system/hardware/kernel.nix
    ../../../system/hardware/power.nix
    ../../../system/hardware/printing.nix

    ../../../system/services/audio.nix
    ../../../system/services/btrfs.nix
    ../../../system/services/display-manager.nix
    ../../../system/services/docker.nix
    ../../../system/services/gpg.nix
    ../../../system/services/network.nix
    ../../../system/services/sshd.nix
    ../../../system/services/time.nix
    ../../../system/services/virtualization.nix
  ];

  hostSpec = {
    username = "profidev";
    hostname = "nix";
  };
}