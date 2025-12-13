{ pkgsUnstableNoCuda, ... }:

{
  services.jellyfin = {
    enable = true;
    package = pkgsUnstableNoCuda.jellyfin;
  };

  environment.systemPackages = with pkgsUnstableNoCuda; [
    makemkv
    mkvtoolnix
    handbrake
    hdr10plus_tool
    ffmpeg
  ];
}
