{ lib, ... }:
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                  "umask=0077"
                ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                };
                passwordFile = "/tmp/disk-encryption.key";

                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-f"
                  ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "defaults"
                        "subvol=root"
                        "compress=zstd"
                        "noatime"
                        "space_cache=v2"
                        "discard=async"
                      ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "defaults"
                        "subvol=home"
                        "compress=zstd"
                        "noatime"
                        "space_cache=v2"
                        "discard=async"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "defaults"
                        "subvol=nix"
                        "compress=zstd"
                        "noatime"
                        "space_cache=v2"
                        "discard=async"
                      ];
                    };
                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "defaults"
                        "subvol=persist"
                        "compress=zstd"
                        "noatime"
                        "space_cache=v2"
                        "discard=async"
                      ];
                    };
                    "/log" = {
                      mountpoint = "/var/log";
                      mountOptions = [
                        "defaults"
                        "subvol=log"
                        "compress=zstd"
                        "noatime"
                        "space_cache=v2"
                        "discard=async"
                      ];
                    };
                    "/swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "16G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  fileSystems."/persist".neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;
}