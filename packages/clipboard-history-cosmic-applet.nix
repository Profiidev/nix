{
  lib,
  fetchFromGitHub,
  libcosmicAppHook,
  rustPlatform,
  just,
  stdenv,
  nix-update-script,
  pkg-config,
}:
rustPlatform.buildRustPackage {
  pname = "clipboard-history-cosmic-applet";
  version = "unstable-2025-10-17";

  src = fetchFromGitHub {
    owner = "ProfiiDev";
    repo = "clipboard-history";
    rev = "58a2417e278217532bf1e09a7f76bd0ab30e571a";
    hash = "sha256-498mquN+aCLq+lo2FRuXq532lzJYm7R2czbqIaKyu+8=";
  };

  cargoHash = "sha256-anDpXQhKv15DRvXJP7fDqNqV4t0sbZ55wdRs9UdS++U=";

  nativeBuildInputs = [
    libcosmicAppHook
    just
    pkg-config
  ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  env = {
    RUSTC_BOOTSTRAP = true;
  };

  cargoBuildFlags = [
    "--package"
    "clipboard-history-cosmic-applet"
  ];

  justFlags = [
    "--justfile"
    "cosmic-applet/justfile"
    "--working-directory"
    "cosmic-applet"
    "--set"
    "prefix"
    (placeholder "out")
    "--set"
    "bin-src"
    "../target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/clipboard-history-cosmic-applet"
    "--set"
    "icon-svg-src"
    "resources/icons/clipboard.svg"
  ];

  doCheck = false;

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A COSMIC applet for ringboard";
    homepage = "https://github.com/ProfiiDev/clipboard-history";
    license = lib.licenses.gpl3Only;
    maintainers = [
    ];
    mainProgram = "clipboard-history-cosmic-applet";
  };
}
