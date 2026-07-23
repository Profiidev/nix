{
  inputs,
  pkgs,
  self,
  ...
}:

{
  imports = [
    ./hardware-config.nix
    ../../spec.nix

    self.modules.services.core.power
    self.modules.services.gui.igpu
    self.modules.services.media.miracast
    self.modules.services.network.cloudflare

    ../../profiles/general.nix
    ../../profiles/system.nix
    ../../profiles/services.nix
    ../../profiles/apps.nix
  ];

  hostSpec = {
    hostname = "laptop";
    users = [
      inputs.nix-secrets.users.profidev
      {
        username = "root";
        secrets_user = "root";
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    mcontrolcenter
  ];
}
