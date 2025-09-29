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
  pname = "cosmic-ext-applet-privacy-indicator";
  version = "0.1.2-unstable-2025-07-03";

  src = fetchFromGitHub {
    owner = "d-brox";
    repo = "cosmic-ext-applet-privacy-indicator";
    rev = "2d3b0efec5a95cf704e414f6e3005641f3aa3666";
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
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-ext-applet-privacy-indicator"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A COSMIC applet for indicating and controlling camera and microphone usage";
    homepage = "https://github.com/d-brox/cosmic-ext-applet-privacy-indicator";
    license = lib.licenses.gpl3Only;
    maintainers = [
    ];
    mainProgram = "cosmic-ext-applet-privacy-indicator";
  };
}
