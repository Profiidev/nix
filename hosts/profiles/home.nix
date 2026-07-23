{ self, ... }:

{
  imports = [
    self.modules.home.sops

    self.modules.home.tools.terminal
    self.modules.home.tools.yubikey
    self.modules.home.tools.virtualization

    self.modules.home.services.media

    self.modules.home.hyprland.default

    self.modules.home.gui.browser
    self.modules.home.gui.theme

    self.modules.home.coding.editor
    self.modules.home.coding.git
    self.modules.home.coding.nvim

    self.modules.home.cli.fastfetch
    self.modules.home.cli.fish
    self.modules.home.cli.gpg
    self.modules.home.cli.shell
    self.modules.home.cli.ssh
    self.modules.home.cli.starship
    self.modules.home.cli.zoxide
  ];
}
