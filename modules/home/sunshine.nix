{ pkgs, ... }:

{
  xdg = {
    autostart.entries = with pkgs; [
      "${moondeck-buddy}/share/applications/MoonDeckBuddy.desktop"
    ];
  };
}
