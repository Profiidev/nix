# NOTE: This ISO is NOT minimal. We don't want a minimal environment when using the iso for recovery purposes.
{ inputs, pkgs, lib, config, ... }:

let name = "iso";
in {
  imports = lib.flatten [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    #"${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
    # This is overkill but I want my core home level utils if I need to use the iso environment for recovery purpose
    inputs.home-manager.nixosModules.home-manager
    (map lib.custom.relativeToRoot [
      "hosts/spec.nix"
      # We want primary default so we get ssh authorized keys, zsh, and some basic tty tools. It also pulls in the hm spec for iso.
      # Note that we are not pulling in "hosts/common/users/primary/nixos.nix" for the iso as it's not needed.
      "system/users/minimal.nix"
      "system/users/normal.nix"
    ])
  ];

  hostSpec = {
    hostname = "iso";
    isMinimal = lib.mkForce true;
    users = [{ username = name; }];
  };

  # root's ssh key are mainly used for remote deployment
  users.extraUsers.root = {
    inherit (config.users.users.${name}) hashedPassword;
    openssh.authorizedKeys.keys =
      config.users.users.${name}.openssh.authorizedKeys.keys;
  };

  environment.etc = {
    isoBuildTime = {
      #
      text = lib.readFile ("${pkgs.runCommand "timestamp" {
        # builtins.currentTime requires --impure
        env.when = builtins.currentTime;
      } "echo -n `date -d @$when  +%Y-%m-%d_%H-%M-%S` > $out"}");
    };
  };

  # Add the build time to the prompt so it's easier to know the ISO age
  programs.bash.promptInit = ''
    export PS1="\\[\\033[01;32m\\]\\u@\\h-$(cat /etc/isoBuildTime)\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\$ "
  '';

  # The default compression-level is (6) and takes too long on some machines (>30m). 3 takes <2m
  isoImage.squashfsCompression = "zstd -Xcompression-level 3";

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    extraOptions = "experimental-features = nix-command flakes";
  };

  services = {
    qemuGuest.enable = true;
    openssh = { settings.PermitRootLogin = lib.mkForce "yes"; };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = lib.mkForce [ "btrfs" "vfat" ];
  };

  networking = { hostName = "iso"; };

  systemd = {
    services.sshd.wantedBy = lib.mkForce [ "multi-user.target" ];
    # gnome power settings to not turn off screen
    targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };
  };
}
