{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  luksDev = "/dev/disk/by-partlabel/disk-disk0-luks";
  hostSystem = pkgs.stdenv.hostPlatform.system;

  rescue = inputs.nixpkgs-unstable.lib.nixosSystem {
    modules = [
      (
        { pkgs, lib, ... }:
        let
          help = pkgs.writeText "rescue-help" ''

            RESCUE SHELL (initrd, RAM only, nothing mounted)

            Remove the TPM slot so the next boot asks for the passphrase:
              systemd-cryptenroll ${luksDev}                       # list slots
              systemd-cryptenroll --wipe-slot=tpm2 ${luksDev}      # asks for passphrase

            Mount the system:
              cryptsetup open ${luksDev} encrypted-nixos
              mkdir -p /mnt && mount -o subvolid=5 /dev/mapper/encrypted-nixos /mnt

          '';

          # The rescue image is signed with your Secure Boot key, so its PCR values
          # may satisfy the TPM policy. Extend the PCRs before the shell starts so it
          # can never unseal the disk key. rescue.service requires this unit: no shell
          # if a TPM is present but locking it fails.
          lockScript = pkgs.writeShellScript "rescue-lock-tpm" ''
            export LD_LIBRARY_PATH=${pkgs.tpm2-tss}/lib
            export TPM2TOOLS_TCTI=device:/dev/tpmrm0
            for _ in $(${pkgs.coreutils}/bin/seq 50); do
              [ -e /dev/tpmrm0 ] && break
              ${pkgs.coreutils}/bin/sleep 0.2
            done
            if [ -e /dev/tpmrm0 ]; then
              h=0000000000000000000000000000000000000000000000000000000000000000
              for pcr in 0 1 2 3 4 5 6 7 11; do
                if ! ${pkgs.tpm2-tools}/bin/tpm2_pcrextend "$pcr:sha256=$h"; then
                  echo "rescue: extending PCR $pcr failed" >&2
                  # 4 and 7 are what a TPM policy normally binds, those must succeed
                  case $pcr in 4|7) exit 1 ;; esac
                fi
                ${pkgs.tpm2-tools}/bin/tpm2_pcrextend "$pcr:sha1=''${h:0:40}" 2>/dev/null || true
              done
            elif [ -e /sys/class/tpm/tpm0 ]; then
              echo "rescue: TPM present but /dev/tpmrm0 missing" >&2
              exit 1
            fi
            ${pkgs.coreutils}/bin/cat ${help}
          '';
        in
        {
          nixpkgs.hostPlatform = hostSystem;
          system.stateVersion = config.system.stateVersion;
          networking.hostName = "rescue";

          boot.kernelPackages = config.boot.kernelPackages;
          hardware.enableRedistributableFirmware = lib.mkForce false;

          fileSystems."/" = {
            device = "none";
            fsType = "tmpfs";
          };

          console = {
            keyMap = config.console.keyMap;
            earlySetup = true;
          };

          boot.initrd = {
            compressor = "zstd";
            compressorArgs = [ "-19" ];
            supportedFilesystems = lib.mkForce [
              "btrfs"
              "vfat"
            ];
            availableKernelModules = config.boot.initrd.availableKernelModules;
            kernelModules = [
              "tpm_tis"
              "tpm_crb"
              "i8042"
              "atkbd"
              "usbhid"
              "hid_generic"
              "xhci_pci"
            ];

            systemd = {
              enable = true;
              tpm2.enable = true;
              emergencyAccess = true;

              extraBin = {
                cryptsetup = "${pkgs.cryptsetup}/bin/cryptsetup";
                systemd-cryptenroll = "${pkgs.systemd}/bin/systemd-cryptenroll";
                btrfs = "${pkgs.btrfs-progs}/bin/btrfs";
                lsblk = "${pkgs.util-linux}/bin/lsblk";
                blkid = "${pkgs.util-linux}/bin/blkid";
                tpm2_pcrread = "${pkgs.tpm2-tools}/bin/tpm2_pcrread";
                tpm2_pcrextend = "${pkgs.tpm2-tools}/bin/tpm2_pcrextend";
                journalctl = "${pkgs.systemd}/bin/journalctl";
                sbctl = "${pkgs.sbctl}/bin/sbctl";
                efibootmgr = "${pkgs.efibootmgr}/bin/efibootmgr";
              };
              storePaths = [
                lockScript
                help
              ];

              # rescue.target (unlike emergency.target) requires sysinit.target, so udev
              # and module loading run before the shell. sysinit.target conflicts with
              # emergency.target, so emergency can not be used for this.
              services.rescue-lock-tpm = {
                requiredBy = [ "rescue.service" ];
                after = [ "sysinit.target" ];
                before = [ "rescue.service" ];
                unitConfig.DefaultDependencies = false;
                serviceConfig = {
                  Type = "oneshot";
                  ExecStart = lockScript;
                  StandardOutput = "journal+console";
                  StandardError = "journal+console";
                };
              };
            };
          };
        }
      )
    ];
  };

  rescueCfg = rescue.config;
  kernel = "${rescueCfg.system.build.kernel}/${rescueCfg.system.boot.loader.kernelFile}";
  initrd = "${rescueCfg.system.build.initialRamdisk}/${rescueCfg.system.boot.loader.initrdFile}";
  cmdline = "rd.systemd.unit=rescue.target console=tty0 loglevel=4";

  osRelease = pkgs.writeText "rescue-os-release" ''
    ID=nixos-rescue
    NAME="Rescue"
    PRETTY_NAME="Rescue (RAM shell)"
    VERSION_ID="1"
  '';

  stamp = builtins.hashString "sha256" "${kernel}${initrd}${cmdline}${osRelease}";

  installScript = pkgs.writeShellScript "rescue-uki-install" ''
    set -euo pipefail
    out=/boot/EFI/Linux/rescue.efi
    state=/var/lib/rescue-uki/stamp
    key=${config.boot.lanzaboote.pkiBundle}/keys/db/db.key
    crt=${config.boot.lanzaboote.pkiBundle}/keys/db/db.pem

    mkdir -p /var/lib/rescue-uki /boot/EFI/Linux
    if [ -f "$out" ] && [ -f "$state" ] && [ "$(cat "$state")" = "${stamp}" ]; then
      exit 0
    fi
    if [ ! -f "$key" ]; then
      echo "Secure Boot key $key missing, skipping rescue UKI" >&2
      exit 0
    fi

    tmp=$(mktemp /var/tmp/rescue-uki.XXXXXX)
    trap 'rm -f "$tmp" /boot/EFI/Linux/.rescue.efi.new' EXIT

    ${pkgs.systemdUkify}/lib/systemd/ukify build \
      --linux ${kernel} \
      --initrd ${initrd} \
      --cmdline ${lib.escapeShellArg cmdline} \
      --os-release @${osRelease} \
      --stub ${config.systemd.package}/lib/systemd/boot/efi/linuxx64.efi.stub \
      --secureboot-private-key "$key" \
      --secureboot-certificate "$crt" \
      --output "$tmp"

    need=$(stat -c %s "$tmp")
    old=0
    [ -f "$out" ] && old=$(stat -c %s "$out")
    avail=$(df --output=avail -B1 /boot | tail -1)
    if [ "$need" -gt $((avail + old)) ]; then
      echo "not enough space on /boot for rescue UKI ($need bytes)" >&2
      exit 1
    fi

    cp "$tmp" /boot/EFI/Linux/.rescue.efi.new
    sync
    mv -f /boot/EFI/Linux/.rescue.efi.new "$out"
    echo "${stamp}" > "$state"
  '';
in
{
  systemd.services.rescue-uki = {
    description = "Build and install signed rescue UKI";
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.sbsigntool ]; # ukify calls sbsign and sbverify
    unitConfig.RequiresMountsFor = [
      "/boot"
      "/var/lib"
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = installScript;
    };
  };
}
