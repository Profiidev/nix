{ config, pkgs, ... }:

{
  networking.hostName = config.hostSpec.hostname;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.firewall.enable = true;
  #networking.firewall.package = pkgs.iptables-legacy;

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
    settings = {
      connectivity = {
        uri = "http://nmcheck.gnome.org/check_network_status.txt";
      };
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.NetworkManager-wait-online-initrd.enable = false;
}
