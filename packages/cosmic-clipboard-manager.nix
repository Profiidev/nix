{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libxkbcommon,
}:

rustPlatform.buildRustPackage {
  pname = "cosmic-clipboard-manager";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "clipboard-manager";
    rev = "master";
    hash = "sha256-FK6GNSl8LDKl6AAJTvOffbG9RdUbufmWxd8nI8Uxw6A=";
  };

  cargoHash = "sha256-cEP4R5AlMLL7mTX6qH7hVLqX83lsQda0lxipQ/FjNkQ=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [ libxkbcommon ];

  meta = with lib; {
    description = "A clipboard manager for Cosmic Desktop";
    homepage = "https://github.com/cosmic-utils/clipboard-manager";
    license = licenses.mit;
    maintainers = [ ];
  };
}
