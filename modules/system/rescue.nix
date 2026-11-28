{
  config,
  lib,
  pkgs,
  ...
}:

let
  luksDev = "/dev/disk/by-partlabel/disk-disk0-luks";

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
  # can never unseal the disk key. rescue-shell.service requires this unit: no
  # shell if a TPM is present but locking it fails.
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

  rescueTarget = pkgs.writeText "rescue-shell.target" ''
    [Unit]
    Description=Rescue Shell
    DefaultDependencies=no
    Requires=sysinit.target rescue-shell.service
    After=sysinit.target rescue-shell.service
    AllowIsolate=yes
  '';

  rescueLockService = pkgs.writeText "rescue-lock-tpm.service" ''
    [Unit]
    Description=Lock TPM PCRs before starting rescue shell
    DefaultDependencies=no
    After=sysinit.target
    Before=rescue-shell.service cryptsetup-pre.target cryptsetup.target

    [Service]
    Type=oneshot
    ExecStart=${lockScript}
    StandardOutput=journal+console
    StandardError=journal+console
  '';

  rescueShellService = pkgs.writeText "rescue-shell.service" ''
    [Unit]
    Description=Rescue Shell (RAM only)
    DefaultDependencies=no
    Requires=rescue-lock-tpm.service
    After=sysinit.target rescue-lock-tpm.service

    [Service]
    Type=idle
    Environment=HOME=/root
    Environment=PATH=/usr/local/bin:/bin:/sbin
    WorkingDirectory=-/root
    ExecStart=-/bin/sh
    StandardInput=tty-force
    StandardOutput=inherit
    StandardError=inherit
    KillMode=process
    IgnoreSIGPIPE=no
    SendSIGHUP=yes
  '';

  rescueModulesConf = pkgs.writeText "rescue-modules.conf" ''
    tpm_tis
    tpm_crb
    i8042
    atkbd
    usbhid
    hid_generic
    xhci_pci
  '';

  # Stacked initrd overlay unpacked by the kernel on top of the host's normal initrd.
  # Keeps the normal host initrd completely free of rescue units and extra tools.
  # Uses /usr/local/{bin,lib/systemd/system} so it never collides with NixOS initrd symlinks
  # (/etc/systemd/system, /bin, /sbin, /usr/bin, /usr/sbin, /lib).
  rescueOverlay = pkgs.makeInitrdNG {
    name = "rescue-overlay-initrd";
    compressor = "zstd";
    compressorArgs = [ "-19" ];
    contents = [
      # Copied at their store paths: ExecStart and the script reference them directly.
      { source = lockScript; }
      { source = help; }
      {
        source = rescueTarget;
        target = "/usr/local/lib/systemd/system/rescue-shell.target";
      }
      {
        source = rescueLockService;
        target = "/usr/local/lib/systemd/system/rescue-lock-tpm.service";
      }
      {
        source = rescueShellService;
        target = "/usr/local/lib/systemd/system/rescue-shell.service";
      }
      {
        source = rescueModulesConf;
        target = "/etc/modules-load.d/rescue.conf";
      }
      {
        source = "${pkgs.cryptsetup}/bin/cryptsetup";
        target = "/usr/local/bin/cryptsetup";
      }
      {
        source = "${pkgs.systemd}/bin/systemd-cryptenroll";
        target = "/usr/local/bin/systemd-cryptenroll";
      }
      {
        source = "${pkgs.btrfs-progs}/bin/btrfs";
        target = "/usr/local/bin/btrfs";
      }
      {
        source = "${pkgs.util-linux}/bin/lsblk";
        target = "/usr/local/bin/lsblk";
      }
      {
        source = "${pkgs.util-linux}/bin/blkid";
        target = "/usr/local/bin/blkid";
      }
      {
        source = "${pkgs.tpm2-tools}/bin/tpm2_pcrread";
        target = "/usr/local/bin/tpm2_pcrread";
      }
      {
        source = "${pkgs.tpm2-tools}/bin/tpm2_pcrextend";
        target = "/usr/local/bin/tpm2_pcrextend";
      }
      {
        source = "${pkgs.systemd}/bin/journalctl";
        target = "/usr/local/bin/journalctl";
      }
      {
        source = "${pkgs.sbctl}/bin/sbctl";
        target = "/usr/local/bin/sbctl";
      }
      {
        source = "${pkgs.efibootmgr}/bin/efibootmgr";
        target = "/usr/local/bin/efibootmgr";
      }
    ];
  };

  kernel = "${config.system.build.kernel}/${config.system.boot.loader.kernelFile}";
  initrd = "${config.system.build.initialRamdisk}/${config.system.boot.loader.initrdFile}";

  # Build-time check: unpack host initrd + overlay the way the kernel stacks them and fail
  # if anything the rescue units run is missing. Catches store paths only the host initrd
  # happens to provide today (bash, coreutils, tcti libs) disappearing later.
  rescueCheck =
    pkgs.runCommand "rescue-initrd-check"
      {
        nativeBuildInputs = [
          pkgs.cpio
          pkgs.libarchive
          pkgs.python3
        ];
        prepend = config.boot.initrd.prepend;
        # Not visible as store references in any text file: dlopen'd lib, tools the help text uses.
        extra = [
          "${pkgs.tpm2-tss}/lib/libtss2-tcti-device.so.0"
          "/bin/sh"
          "/bin/mkdir"
          "/bin/mount"
        ];
        # tpm2-tools wrapper puts this on LD_LIBRARY_PATH; only the abrmd TCTI needs it, we use device.
        ignore = [ "${pkgs.tpm2-abrmd}/lib" ];
      }
      ''
        mkdir root
        skip=0
        for f in $prepend; do skip=$((skip + $(stat -L -c %s "$f"))); done
        tail -c +$((skip + 1)) ${initrd} | bsdcat | (cd root && cpio -idm --quiet --no-absolute-filenames)
        bsdcat < ${rescueOverlay}/initrd | (cd root && cpio -idmu --quiet --no-absolute-filenames)

        python3 - root $extra <<'EOF'
        import os, re, sys
        root, extra = sys.argv[1], sys.argv[2:]
        ignore = set(os.environ["ignore"].split())
        ref = re.compile(rb"/nix/store/[a-z0-9]{32}-[^\s'\"/]+(?:/[^\s'\"]*)?")

        def resolve(p, depth=0):
            # Follow symlinks inside root only; absolute targets must not escape to the build host.
            parts = [x for x in os.path.normpath(p).split("/") if x]
            cur = ""
            for i, part in enumerate(parts):
                full = root + cur + "/" + part
                if os.path.islink(full):
                    if depth > 40:
                        return None
                    t = os.readlink(full)
                    base = t if t.startswith("/") else cur + "/" + t
                    return resolve(base + "/" + "/".join(parts[i + 1 :]), depth + 1)
                if not os.path.lexists(full):
                    return None
                cur += "/" + part
            return root + cur

        unitdir = "/usr/local/lib/systemd/system"
        todo = [unitdir + "/" + u for u in os.listdir(root + unitdir)] + extra
        seen, missing = set(), []
        while todo:
            p = todo.pop()
            if p in seen or p in ignore:
                continue
            seen.add(p)
            real = resolve(p)
            if real is None:
                missing.append(p)
                continue
            if os.path.isfile(real):
                with open(real, "rb") as fh:
                    data = fh.read()
                if not data.startswith(b"\x7fELF"):  # ELF deps are make-initrd-ng's job
                    todo += [m.decode().rstrip(".,;:)") for m in ref.findall(data)]
                    todo += [m.decode() for m in re.findall(rb"^Exec\w+=[-@+!:]*(/\S+)", data, re.M)]

        if missing:
            sys.exit("rescue initrd is missing:\n  " + "\n  ".join(sorted(missing)))
        print(f"rescue initrd ok, {len(seen)} paths checked")
        EOF
        touch $out
      '';
  # rd.luks=0 disables systemd-cryptsetup-generator so sysinit.target never unlocks LUKS;
  # plymouth.enable=0 keeps the console visible for the rescue shell.
  cmdline = "rd.systemd.unit=rescue-shell.target rd.luks=0 rd.fstab=0 plymouth.enable=0 console=tty0 loglevel=4";

  osRelease = pkgs.writeText "rescue-os-release" ''
    ID=nixos-rescue
    NAME="Rescue"
    PRETTY_NAME="Rescue (RAM shell)"
    VERSION_ID="1"
  '';

  stamp = builtins.hashString "sha256" "${kernel}${initrd}${rescueOverlay}${cmdline}${osRelease}";

  installScript = pkgs.writeShellScript "rescue-uki-install" ''
    set -euo pipefail
    # build dependency only, fails the system build if the rescue initrd is incomplete: ${rescueCheck}
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
      --initrd ${rescueOverlay}/initrd \
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
  # Ensure keyboard/TPM modules are available in the host initrd for rescue mode
  # (only loaded on rescue boot via /etc/modules-load.d/rescue.conf in the overlay).
  boot.initrd.availableKernelModules = [
    "tpm_tis"
    "tpm_crb"
    "i8042"
    "atkbd"
    "usbhid"
    "hid_generic"
    "xhci_pci"
  ];

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
