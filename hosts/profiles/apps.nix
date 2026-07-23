{ self, ... }:

{
  imports = [
    self.modules.apps.nix
    self.modules.apps.libs

    self.modules.apps.tools.cli
    self.modules.apps.tools.gui
    self.modules.apps.tools.media
    self.modules.apps.tools.office
    self.modules.apps.tools.proton
    self.modules.apps.tools.terminal

    self.modules.apps.gaming.steam
    self.modules.apps.gaming.minecraft

    self.modules.apps.creative.image
    self.modules.apps.creative.video

    self.modules.apps.coding.cli_tools
    self.modules.apps.coding.code_editor
    self.modules.apps.coding.docker
    self.modules.apps.coding.gui_tools
    self.modules.apps.coding.lang
  ];
}
