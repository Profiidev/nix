{ pkgs, config, ... }:

{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 1d --keep 10";
    clean.dates = "daily";
    flake = config.hostSpec.configPath;
  };

  environment.systemPackages = with pkgs; [
    nix-index
    nil
    nurl
    nixd
    nixfmt-rfc-style
  ];
}
