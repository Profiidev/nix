{ inputs, pkgs, ... }:

{
  _module.args = {
    pkgsStable = import inputs.nixpkgs {
      inherit (pkgs.stdenv.hostPlatform) system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
    pkgsUnstableNoCuda = import inputs.nixpkgs-unstable {
      inherit (pkgs.stdenv.hostPlatform) system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
  };
}
