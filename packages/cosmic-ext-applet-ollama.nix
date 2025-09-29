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
  pname = "cosmic-ext-applet-ollama";
  version = "unstable-2025-06-23";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "cosmic-ext-applet-ollama";
    rev = "3f83ad0a1b4d3a1e113c68229030d7aa25e54185";
    hash = "sha256-4TqlZdzWhZNCpwZmCLlzsdsJxG+JSxnffUg4GUG0C1g=";
  };

  cargoHash = "sha256-NKDUZSo/qq1rSta1d6SNAKNefkbSbzJTo9QPvnjiHXY=";

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
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-ext-applet-ollama"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A COSMIC applet for Ollama AI integration";
    homepage = "https://github.com/cosmic-utils/cosmic-ext-applet-ollama";
    license = lib.licenses.gpl3Only;
    maintainers = [
    ];
    mainProgram = "cosmic-ext-applet-ollama";
  };
}
