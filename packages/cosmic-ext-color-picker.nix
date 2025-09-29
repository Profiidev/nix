{
  lib,
  fetchFromGitHub,
  libcosmicAppHook,
  rustPlatform,
  just,
  stdenv,
  nix-update-script,
}:
rustPlatform.buildRustPackage {
  pname = "cosmic-ext-color-picker";
  version = "1.1.0-unstable-2025-05-27";

  src = fetchFromGitHub {
    owner = "pixeldoted";
    repo = "cosmic-ext-color-picker";
    rev = "c7198fe72dbb15ae514affc77511df33bdab71ec";
    hash = "sha256-3bXlzszo1cVVh1wODsz5wHGUynFfCRjNDXgdmHW5aB0=";
  };

  cargoHash = "sha256-yIqgqsNOlhNhOa0eiJwZT+0plX2bs0HV3RFc0rcSIAg=";

  nativeBuildInputs = [
    libcosmicAppHook
    just
  ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "bin-src"
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-ext-color-picker"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A COSMIC applet for color picking";
    homepage = "https://github.com/pixeldoted/cosmic-ext-color-picker";
    license = lib.licenses.gpl3Only;
    maintainers = [
    ];
    mainProgram = "cosmic-ext-color-picker";
  };
}
