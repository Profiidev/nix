{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    moonlight-qt
    moondeck-buddy
  ];

  services.sunshine = {
    enable = true;
    capSysAdmin = true;
    openFirewall = true;
    package = pkgs.sunshine.override { cudaSupport = true; };
  };

  networking.firewall = {
    allowedUDPPorts = [ 47998 48000 ];
  };
}
