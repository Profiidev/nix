{
  pkgs,
  config,
  inputs,
  isLinux,
  ...
}:

let
  platform = if isLinux then "nixos" else "darwin";
  platformModules = "${platform}Modules";
in
{
  imports = [
    inputs.nix-index-database.${platformModules}.nix-index
  ];

  programs =
    (
      if isLinux then
        {
          nh = {
            enable = true;
            clean.enable = true;
            clean.extraArgs = "--keep-since 1d --keep 10";
            clean.dates = "daily";
            flake = config.hostSpec.configPath;
          };
        }
      else
        { }
    )
    // {
      nix-index-database = {
        comma.enable = true;
      };
    };

  environment.systemPackages = with pkgs; [
    nix-index
    nil
    nurl
    nixd
    nixfmt-rfc-style
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = (map (spec: spec.username) config.hostSpec.users);
  };

  nix.extraOptions = ''
    extra-substituters = https://nix-community.cachix.org https://nix-citizen.cachix.org https://profidev.cachix.org http://192.168.178.22:5000
    extra-trusted-public-keys = nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo= profidev.cachix.org-1:xdwadal2vlCD50JtDTy8NwjOJvkOtjdjy1y91ElU9GE= profidev.cachix.org:tg4xEn64UMdvA5jJYT8omo/CQHk8+spLyeGT2YAku70=
  '';

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      cudaSupport = true;
    };
    overlays = [
      inputs.rust-overlay.overlays.default
      (import ../../packages/overlay.nix)
    ];
  };
}
