{
  lib,
  fetchFromGitHub,
  rustPlatform,
  libcosmicAppHook,
  just,
  stdenv,
  nix-update-script,
  pkg-config,
  udev,
}:

rustPlatform.buildRustPackage {
  pname = "cosmic-ext-applet-external-monitor-brightness";
  version = "0-unstable-2025-09-17";

  src = fetchFromGitHub {
    owner = "maciekk64";
    repo = "cosmic-ext-applet-external-monitor-brightness";
    rev = "1f648171fcc1b187ca6603b78c650ea0f33daa79";
    hash = "sha256-IncYmqAZjocSSxw+5wemKjEYWfp/0YfXvHTv2rYLdSs=";
  };

  cargoHash = "sha256-kOK4Ndk2vLRucZ318doiYsYEzh5ugUaj23OQ48WRwh0=";

  nativeBuildInputs = [
    libcosmicAppHook
    just
    pkg-config
  ];

  buildInputs = [
    udev
  ];

  dontUseJustBuild = true;
  dontUseJustCheck = true;

  justFlags = [
    "--set"
    "prefix"
    (placeholder "out")

    "--set"
    "bin-src"
    "./target/${stdenv.hostPlatform.rust.cargoShortTarget}/release/cosmic-ext-applet-external-monitor-brightness"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    homepage = "https://github.com/maciekk64/cosmic-ext-applet-external-monitor-brightness";
    description = "Change brightness of external monitors via DDC/CI protocol and also quickly toggle COSMIC system dark mode";
    license = lib.licenses.gpl3Only;
    maintainers = [
    ];
    platforms = lib.platforms.linux;
    mainProgram = "cosmic-ext-applet-external-monitor-brightness";
  };
}
