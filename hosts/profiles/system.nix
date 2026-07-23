{ self, ... }:

{
  imports = [
    self.modules.system.boot
    self.modules.system.firmware
    self.modules.system.font
    self.modules.system.general
    self.modules.system.kernel
    self.modules.system.locale
    self.modules.system.sops
  ];
}
