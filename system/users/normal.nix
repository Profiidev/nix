{ lib, config, inputs, pkgs, host, ... }:

let
  hostSpec = config.hostSpec;
  userSpec = config.userSpec;
  pubKeys = lib.filesystem.listFilesRecursive ../../keys;
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

  sopsHashedPasswordFile = lib.mkIf (!hostSpec.isMinimal)
    config.sops.secrets."passwords/${userSpec.username}".path;
in {
  users.users.${userSpec.username} = {
    isNormalUser = true;
    extraGroups = lib.flatten [
      "wheel"
      (ifTheyExist [
        "audio"
        "video"
        "docker"
        "git"
        "vboxusers"
        "networkmanager"
        "scanner" # for print/scan"
        "lp" # for print/scan"
      ])
    ];
    hashedPasswordFile = sopsHashedPasswordFile;

    openssh.authorizedKeys.keys =
      lib.lists.forEach pubKeys (key: builtins.readFile key);
  };
} // lib.optionalAttrs (inputs ? "home-manager") {
  home-manager = {
    extraSpecialArgs = {
      inherit pkgs inputs;
      hostSpec = config.hostSpec;
      userSpec = config.userSpec;
    };

    users.${userSpec.username} = {
      home.stateVersion = "24.11";

      imports = lib.flatten (lib.optional (!hostSpec.isMinimal) [
        ({ config, ... }:
          import (lib.custom.relativeToRoot "hosts/profiles/${host}/home.nix") {
            inherit pkgs inputs config lib hostSpec userSpec host;
          })
      ]);
    };
  };
}
