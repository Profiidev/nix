{ config, lib, pkgs, inputs, ... }:

let
  sopsHashedPasswordFile = lib.optionalString (!config.hostSpec.isMinimal)
    config.sops.secrets."passwords/root".path;
in {
  users.users.root = { hashedPasswordFile = sopsHashedPasswordFile; };
} // lib.optionalAttrs (inputs ? "home-manager") {
  home-manager = {
    extraSpecialArgs = {
      inherit pkgs inputs;
      hostSpec = config.hostSpec;
      userSpec = config.userSpec;
    };

    users.root = {
      home.stateVersion = "24.11";

      imports = [ ];
    };
  };
}
