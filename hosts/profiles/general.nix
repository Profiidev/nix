{ self, ... }:

{
  imports = [
    self.modules.inputs
    self.modules.users.normal
  ];
}
