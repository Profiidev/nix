{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    godot
    unityhub
    _7zip-zstd
  ];

  services.wivrn = {
    enable = true;
    openFirewall = true;
    autoStart = true;
    steam.importOXRRuntimes = true;
    highPriority = true;
  };
}
