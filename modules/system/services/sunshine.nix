{ pkgs, config, ... }:

let
  users = config.hostSpec.users;
  userPaths = map (user: "/etc/profiles/per-user/${user.username}/bin") users;
  userPath = builtins.concatStringsSep ":" userPaths;
in
{
  environment.systemPackages = with pkgs; [
    moonlight-qt
    moondeck-buddy
  ];

  services.sunshine = {
    enable = false;
    capSysAdmin = true;
    openFirewall = true;
    package = pkgs.sunshine.override { cudaSupport = true; };
    applications = {
      env = {
        PATH = "$(PATH):/run/current-system/sw/bin:${userPath}:$(HOME)/.local/bin";
      };
      apps = [
        {
          name = "Desktop";
          image-path = "desktop.png";
        }
        {
          name = "MoonDeckStream";
          cmd = "${pkgs.moondeck-buddy}/bin/MoonDeckStream";
          exclude-global-prep-cmd = "false";
          elevated = "false";
        }
        {
          name = "Steam Big Picture";
          image-path = "steam.png";
          detached = [ "steam steam://open/bigpicture" ];
          auto-detach = "true";
          wait-all = "true";
          exit-timeout = "5";
        }
      ];
    };
    settings = {
      output_name = 1;
    };
  };

  networking.firewall = {
    allowedUDPPorts = [
      5000
      47998
      48000
      59999
    ];

    allowedTCPPorts = [
      5000
      47998
      48000
      59999
    ];
  };
}
