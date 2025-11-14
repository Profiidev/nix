{
  lib,
  fetchFromGitHub,
  libcosmicAppHook,
  rustPlatform,
  just,
  stdenv,
  nix-update-script,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "minimon-applet";
  version = "unstable-2025-09-26";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "minimon-applet";
    rev = "4cc2c55e7ca8a949269aefe82c09067cf3ff3c71";
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
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-applet-minimon"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A COSMIC applet for displaying CPU/Memory/Network/Disk/GPU usage in the Panel or Dock";
    homepage = "https://github.com/cosmic-utils/minimon-applet";
    license = lib.licenses.gpl3Only;
    maintainers = [
    ];
    mainProgram = "minimon-applet";
  };
}
