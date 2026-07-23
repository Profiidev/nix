{ inputs, self, ... }:

{
  imports = [
    ./hardware-config.nix
    ../../spec.nix
    
    self.modules.system.boot

    self.modules.system.boot
    self.modules.system.firmware
    self.modules.system.font
    self.modules.system.general
    self.modules.system.kernel
    self.modules.system.locale
    self.modules.system.sops

    # Profiles
    ../../../modules/profiles/system/base.nix
    ../../../modules/profiles/system/coding.nix
    ../../../modules/profiles/system/pc.nix

    ../../../modules/profiles/apps/base.nix
    ../../../modules/profiles/apps/gaming.nix
    ../../../modules/profiles/apps/graphics.nix
    ../../../modules/profiles/apps/office.nix

    # Extra
    ../../../modules/apps/ai.nix
    ../../../modules/apps/gamedev.nix
    ../../../modules/apps/jellyfin.nix
    ../../../modules/apps/tailscale.nix
  ];

  hostSpec = {
    hostname = "home";
    users = [
      inputs.nix-secrets.users.profidev
      {
        username = "root";
        secrets_user = "root";
      }
    ];
  };
}
