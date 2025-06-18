{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    moonlight-qt
  ];

  services.sunshine = {
    enable = false;
    capSysAdmin = true;
    openFirewall = true;
    package = pkgs.sunshine.override { cudaSupport = true; };
  };

  networking.firewall = {
    allowedUDPPorts = [ 47998 48000 ];
  };
}
