{ config, inputs, lib, ... }:

{
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.disko
    inputs.sops-nix.nixosModules.sops
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = (map (spec: spec.username) config.hostSpec.users);
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    overlays = [
      inputs.rust-overlay.overlays.default
      (import ../packages/overlay.nix)
    ];
  };

  systemd.tmpfiles.rules =
    [ "L+ /usr/local/bin - - - - /run/current-system/sw/bin/" ];

  system.stateVersion = "25.05";
}
