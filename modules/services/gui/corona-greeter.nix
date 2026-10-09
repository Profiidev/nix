{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.custom-nixpkgs.corona.nixosModules.greeter
  ];

  security.pam.services.greetd = {
    enable = true;
    fprintAuth = true;
    u2fAuth = true;
  };

  services.corona-greeter = {
    enable = true;

    settings.monitor = "DP-1";
    keyboard.layout = "de";

    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    profileIcons = {
      profidev = ../../../assets/images/profidev.jpeg;
    };
  };
}
