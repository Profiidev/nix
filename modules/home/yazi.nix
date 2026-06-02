{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ueberzugpp
  ];

  wayland.windowManager.hyprland.extraConfig = builtins.readFile ../../assets/hyprland/yazi.lua;

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";

    settings = {
      mgr = {
        sort_by = "natural";
        sort_sensitive = false;
        sort_dir_first = true;
        show_hidden = true;
        show_symlink = true;
      };
      preview = {
        max_width = 1000;
        max_height = 1000;
      };
    };

    initLua = ''
      -- require("full-border"):setup()
      -- require("starship"):setup()
    '';
  };
}
