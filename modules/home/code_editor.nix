{ ... }:

let
  settings = builtins.readFile ../../assets/other/zed.json;
in
{
  programs.zed-editor = {
    enable = true;
    userSettings = builtins.fromJSON settings;
    installRemoteServer = true;
  };
}
