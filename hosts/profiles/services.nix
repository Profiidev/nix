{ self, ... }:

{
  imports = [
    self.modules.services.core.audio
    self.modules.services.core.bluetooth
    self.modules.services.core.btrfs
    self.modules.services.core.gpg
    self.modules.services.core.security
    self.modules.services.core.time

    self.modules.services.network.network
    self.modules.services.network.sshd
    self.modules.services.network.tailscale

    self.modules.services.media.media
    self.modules.services.media.printing

    self.modules.services.gui.display-manager
    self.modules.services.gui.noctalia-legacy
    #self.modules.services.gui.noctalia
    self.modules.services.gui.sddm
    #self.modules.services.gui.noctalia-greeter

    self.modules.services.coding.docker
  ];
}
