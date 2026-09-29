{ pkgs, ... }:

{
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
  };

  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      /*
        # Minecraft Dungeons II, see https://github.com/ValveSoftware/Proton/issues/10193
        (proton-ge-bin.overrideAttrs {
          pname = "gdk-proton-bin";
          version = "GDK-Proton11-7";
          steamDisplayName = "GDK-Proton";
          toolName = "GE-Proton11-7-x86_64";
          src = fetchzip {
            url = "https://github.com/LukasPAH/GDK-Proton-Custom/releases/download/release-11-7/GDK-Proton11-7-x86_64.tar.gz";
            hash = "sha256-+K3u9LsgEfwhfvIQjHa09mvtUe1LHMQ/yG3vICXpvpU=";
          };
          })
      */
    ];
    protontricks.enable = true;
  };
}
