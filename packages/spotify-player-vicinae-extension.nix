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
      hash = "sha256-Fz/3p980APjEr2q0V3mQ+QIk3rknJK9MAF15BK/zLic=";

      sparseCheckout = [
        "extensions/spotify-player"
      ];
    }
  }/extensions/spotify-player";

  buildPhase = "npm run build -- -o=$out";
}
