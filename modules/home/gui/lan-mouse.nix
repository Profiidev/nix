{
  lib,
  pkgs,
  config,
  hostSpec,
  ...
}:

let
  # the other machine as seen from each host
  peers = {
    home = {
      hostname = "100.108.113.101";
      position = "left";
      name = "laptop";
      fingerprint = "5d:36:ce:43:a1:d2:89:fb:8c:e1:9e:33:88:b6:16:a5:d4:0c:7c:96:91:65:d1:c4:5e:f1:77:bf:d6:ef:86:52";
    };
    laptop = {
      hostname = "192.168.178.22";
      position = "right";
      name = "home";
      fingerprint = "6f:ec:08:dd:3f:03:9f:17:eb:10:ac:6d:0a:f2:ca:7b:f3:55:d4:4b:a5:78:43:79:66:6c:61:17:da:a7:fe:59";
    };
  };
  peer = peers.${hostSpec.hostname} or null;
  configFile = "lan-mouse/config.toml";
in
lib.mkIf (peer != null) {
  home.packages = with pkgs; [
    lan-mouse
  ];

  sops.secrets.lan-mouse = {
    mode = "0600";
    path = "${config.xdg.configHome}/lan-mouse/lan-mouse.pem";
  };

  xdg.configFile.${configFile}.text = ''
    [[clients]]
    hostname = "${peer.hostname}"
    ips = []
    position = "${peer.position}"
    activate_on_startup = true

    [authorized_fingerprints]
    "${peer.fingerprint}" = "${peer.name}"
  '';

  systemd.user.services.lan-mouse = {
    Unit = {
      Description = "Lan Mouse";
      After = [
        "graphical-session.target"
        "sops-nix.service"
      ];
      PartOf = [ "graphical-session.target" ];
      X-Restart-Triggers = [ config.xdg.configFile.${configFile}.source ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = with pkgs; {
      ExecStart = "${lan-mouse}/bin/lan-mouse daemon";
      Restart = "always";
      RestartSec = 5;
    };
  };
}
