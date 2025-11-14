{ final, prev, mkBunDerivation, ... }:

  {
    # required for betaflight
    nwjs = prev.nwjs.overrideAttrs {
      version = "0.84.0";
      src = prev.fetchurl {
        url = "https://dl.nwjs.io/v0.84.0/nwjs-v0.84.0-linux-x64.tar.gz";
        hash = "sha256-VIygMzCPTKzLr47bG1DYy/zj0OxsjGcms0G1BkI/TEI=";
      };
    };
  }
  // builtins.listToAttrs (
    map
      (pkg: {
        name = pkg;
        value = final.callPackage ./${pkg}.nix {
          inherit mkBunDerivation;
        };
      })
      (
        builtins.filter (pkg: pkg != "overlay") (
          map (pkg: prev.lib.removeSuffix ".nix" pkg) (builtins.attrNames (builtins.readDir ./.))
        )
      )
  )
