{
  stdenv,
  fetchFromGitHub,
  bibata-cursors,
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

  buildInputs = [ bibata-cursors ];

  postInstall = ''
    # set cursor theme to bibata-cursors
    echo "CursorTheme=Bibata-Modern-Ice" >> $out/share/sddm/themes/clean/theme.conf
  '';

  src = fetchFromGitHub {
    owner = "saatvik333";
    repo = "obscure-sddm-theme";
    rev = "855229260bb6f9070244277994273572212be15e";
    hash = "sha256-WMx1SSG1L687ScPSeaZa4FuIoZSdnUidB3n44vyLCwY=";
  };
}
