{ config, inputs, lib, pkgs, ... }:

{
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" config.userSpec.username ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    overlays = [
      inputs.rust-overlay.overlays.default
      (final: prev: {
        mutter = prev.mutter.overrideAttrs (old: {
          src = pkgs.fetchFromGitLab {
            domain = "gitlab.gnome.org";
            owner = "vanvugt";
            repo = "mutter";
            rev = "triple-buffering-v4-47";
            hash = "sha256-C2VfW3ThPEZ37YkX7ejlyumLnWa9oij333d5c4yfZxc=";
          };
        });
      })
    ];
  };

  systemd.tmpfiles.rules =
    [ "L+ /usr/local/bin - - - - /run/current-system/sw/bin/" ];

  system.stateVersion = "25.05";
}
