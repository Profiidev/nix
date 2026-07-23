{ config, ... }:

{
  networking.hostName = config.hostSpec.hostname;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  #networking.firewall.package = pkgs.iptables-legacy;

  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.NetworkManager-wait-online-initrd.enable = false;
}
