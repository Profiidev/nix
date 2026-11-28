{ pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    package = pkgs.jellyfin;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    #makemkv
    mkvtoolnix
    hdr10plus_tool
    ffmpeg-full
  ];
}
