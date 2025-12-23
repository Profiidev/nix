{
  inputs,
  pkgs,
  ...
}:

let
  system = pkgs.stdenv.hostPlatform.system;
  mkVicinaeExtension = inputs.vicinae.packages.${system}.mkVicinaeExtension;

  vicinaeVsCode = mkVicinaeExtension {
    pname = "vscode-recent-projects-vicinae-extension";

    src = "${
      pkgs.fetchFromGitHub {
        owner = "raycast";
        repo = "extensions";
        rev = "3745b33cbc5ae69d99eb0ded423eab1b494272a0";
        hash = "sha256-nWG2KumFe8X8c898F95fIZKxGerp6PRlTaoL+AtSZAQ=";
      }
    }/extensions/visual-studio-code-recent-projects";

    buildPhase = "npm run build -- -o=$out";
    patches = [
      ../../patches/vscode-vicinae-extension.patch
    ];

    runtimeDependencies = with pkgs; [
      sqlite
    ];
  };

  vicinaeSpotify = mkVicinaeExtension {
    pname = "spotify-player-vicinae-extension";

    src = "${
      pkgs.fetchFromGitHub {
        owner = "raycast";
        repo = "extensions";
        rev = "3745b33cbc5ae69d99eb0ded423eab1b494272a0";
        hash = "sha256-nWG2KumFe8X8c898F95fIZKxGerp6PRlTaoL+AtSZAQ=";
      }
    }/extensions/spotify-player";

    buildPhase = "npm run build -- -o=$out";
  };

  vicinaeGoogle = mkVicinaeExtension {
    pname = "google-vicinae-extension";

    src = "${
      pkgs.fetchFromGitHub {
        owner = "raycast";
        repo = "extensions";
        rev = "3745b33cbc5ae69d99eb0ded423eab1b494272a0";
        hash = "sha256-nWG2KumFe8X8c898F95fIZKxGerp6PRlTaoL+AtSZAQ=";
      }
    }/extensions/google-search";

    buildPhase = "npm run build -- -o=$out";
  };
in
{
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  services.vicinae = {
    enable = true;
    autoStart = true;

    extensions = with inputs.vicinae-extensions.packages.${system}; [
      bluetooth
      nix
      power-profile
      it-tools
      port-killer
      vicinaeSpotify
      vicinaeVsCode
      vicinaeGoogle
    ];
  };

  home.file.".config/vicinae/settings.json".source = ../../assets/vicinae.json;

  home.packages = with pkgs; [
    sqlite
  ];
}
# layer config + file structure
