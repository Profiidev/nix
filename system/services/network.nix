{ meta, ... }:

{
  networking.hostName = meta.hostname;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;
  networking.useDHCP = lib.mkDefault true;
  networking.firewall.enable = true;

  users.user.${meta.username}.extraGroups = [ "networkmanager" ];
}