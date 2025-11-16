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
  pname = "gui-scale-applet";
  version = "2.0.0-unstable-2025-08-06";

  src = fetchFromGitHub {
    owner = "cosmic-utils";
    repo = "gui-scale-applet";
    rev = "4e4074738626fafeee26d9cb38c8587899242f0a";
    hash = "sha256-dhJxrWApSpEbq2onsg/fb5j6i5/7+pBytOUcOgFKlZA=";
  };

  cargoHash = lib.fakeHash;

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
    "target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/gui-scale-applet"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A COSMIC applet for managing tailscale VPN connections";
    homepage = "https://github.com/cosmic-utils/gui-scale-applet";
    license = lib.licenses.gpl3Only;
    maintainers = [
    ];
    mainProgram = "gui-scale-applet";
  };
}
