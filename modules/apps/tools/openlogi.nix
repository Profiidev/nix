{
  inputs,
  ...
}:

{
  imports = [
    inputs.custom-nixpkgs.openlogi.nixosModules.default
  ];

  programs.openlogi = {
    enable = true;
  };
}
