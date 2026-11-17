{
  inputs,
  hostSpec,
  lib,
  pkgs,
  ...
}:

let
  readToml = file: fromTOML (builtins.readFile file);
in
{
  imports = [
    inputs.custom-nixpkgs.umbriel.homeModules.default
    ../desktop
  ];

  # settings is a TOML-typed option, so tables from every module merge and rule lists concatenate.
  programs.umbriel = {
    enable = true;
    package = pkgs.umbriel;

    settings = lib.mkMerge (
      map readToml [
        ../../../assets/umbriel/config.toml
        ../../../assets/umbriel/io.toml
        ../../../assets/umbriel/keybinds.toml
        ../../../assets/umbriel/rules.toml
        ../../../assets/umbriel/style.toml
        ../../../assets/umbriel/corona.toml
        ../../../assets/umbriel/positron.toml
      ]
      ++ [
        (fromTOML hostSpec.umbrielMonitorConfig)
        (lib.mkIf hostSpec.hyprlandHiDpiFix {
          general.xwayland_native_resolution = true;
        })
      ]
    );
  };
}
