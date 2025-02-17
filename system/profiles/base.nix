{ ... }:

{
  imports = [
    ../general.nix
    ../locale.nix
    ../sops.nix

    ../apps/base.nix
    ../apps/flatpak.nix

    ../hardware/bluetooth.nix
    ../hardware/boot.nix
    ../hardware/kernel.nix
    ../hardware/printing.nix

    ../media/base.nix

    ../services/audio.nix
    ../services/btrfs.nix
    ../services/display-manager.nix
    ../services/gpg.nix
    ../services/network.nix
    ../services/security.nix
    ../services/sshd.nix
    ../services/time.nix

    ../users/normal.nix
    ../users/root.nix
  ];
}
