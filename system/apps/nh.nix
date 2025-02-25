{ ... }:

{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 1d --keep 10";
    clean.dates = "daily";
    flake = "/etc/nixos/nix-config";
  };
}
