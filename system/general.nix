{ config, inputs, lib, ... }:

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
          src = inputs.mutter-triple-buffering-src;
          preConfigure = ''
            cp -a "${inputs.gvdb-src}" ./subprojects/gvdb
          '';
        });
      })
    ];
  };

  systemd.tmpfiles.rules =
    [ "L+ /usr/local/bin - - - - /run/current-system/sw/bin/" ];

  system.stateVersion = "25.05";
}
