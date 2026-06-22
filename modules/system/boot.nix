{
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  boot.loader.timeout = 0;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
    autoGenerateKeys.enable = true;
    autoEnrollKeys.enable = true;
    autoEnrollKeys.autoReboot = true;

    configurationLimit = 8;
    measuredBoot = {
      enable = true;
      pcrs = [
        0
        2
        3
        4
        7
      ];
    };
  };

  boot.plymouth.enable = true;

  environment.systemPackages = with pkgs; [
    efibootmgr
    ntfs3g
    sbctl
  ];
}
