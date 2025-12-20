{
  stdenv,
  fetchFromGitHub,
  kdePackages,
  ...
}:

stdenv.mkDerivation {
  pname = "sddm-theme-clean";
  version = "1.0.0";

  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/clean
  '';

  buildInputs = [
    kdePackages.qt5compat
    kdePackages.qtdeclarative
    kdePackages.qtsvg
    kdePackages.sddm
  ];
  dontWrapQtApps = true;

  src = fetchFromGitHub {
    owner = "saatvik333";
    repo = "obscure-sddm-theme";
    rev = "855229260bb6f9070244277994273572212be15e";
    hash = "sha256-WMx1SSG1L687ScPSeaZa4FuIoZSdnUidB3n44vyLCwY=";
  };
}
