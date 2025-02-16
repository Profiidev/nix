{ lib, ... }:

{
  imports = lib.flatten [
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

    # Profiles
    ../../../system/profiles/base.nix
    ../../../system/profiles/coding.nix
    ../../../system/profiles/gaming.nix

    # Extra
    ../../../system/media/obs.nix
  ];

  hostSpec = {
    hostname = "home";
    username = "profidev";
    git_user = "ProfiiDev";
    git_email = "92174452+Profiidev@users.noreply.github.com";
    ssh_keys = [
      "ed25519_sk"
    ];
  };
}