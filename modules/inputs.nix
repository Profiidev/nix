{ inputs, pkgs, ... }:

let
  customNixpkgs = inputs.custom-nixpkgs.inputs.nixpkgs;
  noCudaNixpkgs =
    if customNixpkgs.rev == inputs.nixpkgs-unstable.rev then customNixpkgs else inputs.nixpkgs-unstable;
in
{
  _module.args = {
    pkgsUnstableNoCuda = noCudaNixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  };
}
