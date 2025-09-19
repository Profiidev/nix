{ ... }:

{
  imports = [
    ../../general.nix
    ../../locale.nix
    ../../sops.nix

    ../../system/boot.nix
    ../../system/kernel.nix

    ../../system/hardware/audio.nix
    ../../system/hardware/bluetooth.nix
    ../../system/hardware/network.nix
    ../../system/hardware/printing.nix

    ../../system/services/btrfs.nix
    ../../system/services/display-manager.nix
    ../../system/services/font.nix
    ../../system/services/gpg.nix
    ../../system/services/security.nix
    ../../system/services/sshd.nix
    ../../system/services/time.nix

    ../../users/normal.nix
  ];
}
