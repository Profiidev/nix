{ ... }:

{
  programs.aerospace = {
    enable = true;
    launchd.enable = true;
    settings = {
      config-version = 2;

      persistent-workspaces = [
        "1"
        "2"
        "3"
        "magic-e"
        "magic-d"
      ];

      workspace-to-monitor-force-assignment = {
        "1" = 3;
        "2" = "main";
        "3" = "built-in";
      };

      mode.main.binding = {
        cmd-t = "exec-and-forget open -n \"~/Applications/Home Manager Apps/Alacritty.app\"";
        ctrl-f = "fullscreen";
        alt-f = "layout floating tiling";

        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";
        alt-left = "focus left";
        alt-down = "focus down";
        alt-up = "focus up";
        alt-right = "focus right";

        cmd-h = "move left";
        cmd-j = "move down";
        cmd-k = "move up";
        cmd-l = "move right";
        cmd-left = "move left";
        cmd-down = "move down";
        cmd-up = "move up";
        cmd-right = "move right";

        cmd-1 = "workspace 1";
        cmd-2 = "workspace 2";
        cmd-3 = "workspace 3";
        cmd-4 = "workspace 4";
        cmd-5 = "workspace 5";
        cmd-6 = "workspace 6";
        cmd-7 = "workspace 7";
        cmd-8 = "workspace 8";
        cmd-9 = "workspace 9";
        cmd-0 = "workspace 10";

        cmd-shift-1 = "move-node-to-workspace 1";
        cmd-shift-2 = "move-node-to-workspace 2";
        cmd-shift-3 = "move-node-to-workspace 3";
        cmd-shift-4 = "move-node-to-workspace 4";
        cmd-shift-5 = "move-node-to-workspace 5";
        cmd-shift-6 = "move-node-to-workspace 6";
        cmd-shift-7 = "move-node-to-workspace 7";
        cmd-shift-8 = "move-node-to-workspace 8";
        cmd-shift-9 = "move-node-to-workspace 9";
        cmd-shift-0 = "move-node-to-workspace 10";

        cmd-e = "summon-workspace magic-e";
        cmd-shift-e = "move-node-to-workspace magic-e";
        cmd-d = "summon-workspace magic-d";
        cmd-shift-d = "move-node-to-workspace magic-d";
      };
    };
  };
}
