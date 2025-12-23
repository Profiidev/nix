{
  mkVicinaeExtension,
  fetchFromGitHub,
  ...
}:

mkVicinaeExtension {
  pname = "spotify-player-vicinae-extension";

  src = "${
    fetchFromGitHub {
      owner = "raycast";
      repo = "extensions";
      rev = "3745b33cbc5ae69d99eb0ded423eab1b494272a0";
      hash = "sha256-nWG2KumFe8X8c898F95fIZKxGerp6PRlTaoL+AtSZAQ=";
    }
  }/extensions/spotify-player";

  buildPhase = "npm run build -- -o=$out";
}
