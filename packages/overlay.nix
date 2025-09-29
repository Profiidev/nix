(final: prev: {
  moondeck-buddy = prev.callPackage ./moondeck-buddy.nix { };
  cosmic-ext-applet-clipboard-manager =
    prev.callPackage ./cosmic-ext-applet-clipboard-manager.nix
      { };
  cosmic-ext-tweaks = prev.callPackage ./cosmic-ext-tweaks.nix { };
  cosmic-ext-applet-external-monitor-brightness =
    prev.callPackage ./cosmic-ext-applet-external-monitor-brigthness.nix
      { };

  # required for betaflight
  nwjs = prev.nwjs.overrideAttrs {
    version = "0.84.0";
    src = prev.fetchurl {
      url = "https://dl.nwjs.io/v0.84.0/nwjs-v0.84.0-linux-x64.tar.gz";
      hash = "sha256-VIygMzCPTKzLr47bG1DYy/zj0OxsjGcms0G1BkI/TEI=";
    };
  };
})
