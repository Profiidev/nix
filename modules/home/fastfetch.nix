{ isLinux, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = builtins.fromJSON ''
      {
        "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
        "logo": {
          "type": "builtin",
          "source": "${if isLinux then "nixos" else "macos"}"
        },
        "modules": [
            "title",
            "separator",
            {
              "type": "os",
              "format": "${if isLinux then "Nixos" else "Macos"} ({12})"
            },
            "host",
            "kernel",
            "uptime",
            "packages",
      	    "processes",
            "shell",
            "display",
            "de",
            "wm",
            "terminal",
            "cpu",
            "gpu",
            "memory",
            {
              "type": "disk",
      	      "folders": "/"
            },
            "battery",
            "poweradapter",
            "break",
            "colors"
        ]
      }
    '';
  };
}
