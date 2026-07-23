{ self, ... }:

{
  imports = [
    self.modules.home.cli.fastfetch
    self.modules.home.cli.fish
    self.modules.home.cli.shell
    self.modules.home.cli.starship
    self.modules.home.cli.zoxide
  ];
}
