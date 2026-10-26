{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    corona
    nautilus
    kdePackages.qttools
    ddcutil
    wireguard-tools
  ];

  imports = [
    ./hyprland.nix
  ];

  environment.pathsToLink = [ "/share/corona" ];

  hardware.i2c.enable = true;
  boot.kernelModules = [ "i2c-dev" ];

  # kde connect
  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  services.hypridle.enable = lib.mkForce false;
  security.pam.services.corona.fprintAuth = lib.mkDefault false;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.gnome.evolution-data-server.enable = true;

  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  # eduroam floods mDNS, avahi spins at 100% CPU: stop it while connected there
  networking.networkmanager.dispatcherScripts = [
    {
      source = pkgs.writeShellScript "avahi-eduroam" ''
        case "$2" in up | down) ;; *) exit 0 ;; esac
        if ${pkgs.networkmanager}/bin/nmcli -t -f NAME connection show --active | ${pkgs.gnugrep}/bin/grep -qx eduroam; then
          ${pkgs.systemd}/bin/systemctl stop avahi-daemon.socket avahi-daemon.service
        else
          ${pkgs.systemd}/bin/systemctl start avahi-daemon.socket avahi-daemon.service
        fi
      '';
    }
  ];
  hardware.sane.enable = true;

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "alacritty";
  };
}
