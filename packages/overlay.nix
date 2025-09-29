(final: prev: {
  moondeck-buddy = prev.callPackage ./moondeck-buddy.nix { };
  cosmic-clipboard-manager = prev.callPackage ./cosmic-clipboard-manager.nix { };
  # required for betaflight
  nwjs = prev.nwjs.overrideAttrs {
    version = "0.84.0";
    src = prev.fetchurl {
      url = "https://dl.nwjs.io/v0.84.0/nwjs-v0.84.0-linux-x64.tar.gz";
      hash = "sha256-VIygMzCPTKzLr47bG1DYy/zj0OxsjGcms0G1BkI/TEI=";
    };
  };
})
