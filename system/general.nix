{ meta, inputs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = ["root" meta.username];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
    hostPlatform = lib.mkDefault "x86_64-linux";
      overlays = [ inputs.rust-overlay.overlays.default ];
  };

  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];

  programs.home-manager.enable = true;
}