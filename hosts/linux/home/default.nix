{ inputs, self, ... }:

{
  imports = [
    ./hardware-config.nix
    ../../spec.nix

    self.modules.system.no-sleep

    self.modules.services.gui.nvidia
    self.modules.services.gui.flatpak
    self.modules.services.core.cooling
    self.modules.services.network.nix-serve
    self.modules.services.media.gpu-screen-recorder
    self.modules.services.media.jellyfin
    self.modules.services.media.ollama
    self.modules.services.coding.virtualization

    self.modules.apps.coding.gamedev
    self.modules.apps.coding.graphics_coding
    self.modules.apps.creative."3d"
    self.modules.apps.creative."3d_print"
    self.modules.apps.gaming.games
    self.modules.apps.tools.betaflight
    self.modules.apps.tools.profiling

    ../../profiles/general.nix
    ../../profiles/system.nix
    ../../profiles/services.nix
    ../../profiles/apps.nix
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
