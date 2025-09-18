{
  lib,
  config,
  inputs,
  pkgs,
  pkgsUnstable,
  pkgsUnstableCuda,
  ...
}:

let
  hostSpec = config.hostSpec;
  pubKeys = lib.filesystem.listFilesRecursive ../../keys;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users.mutableUsers = false;

  users.users = lib.foldl (
    acc: spec:
    acc
    // {
      "${spec.username}" = {
        isNormalUser = spec.username != "root";
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
            "gamemode"
            "dialout" # for betaflight
          ])
        ];
        hashedPasswordFile = lib.mkIf (
          !hostSpec.isMinimal
        ) config.sops.secrets."passwords/${spec.username}".path;

        openssh.authorizedKeys.keys = lib.lists.forEach pubKeys (key: builtins.readFile key);
      };
    }
  ) { } hostSpec.users;
}
// lib.optionalAttrs (inputs ? "home-manager") {
  home-manager = {
    extraSpecialArgs = {
      inherit
        pkgs
        inputs
        pkgsUnstable
        pkgsUnstableCuda
        ;
      hostSpec = config.hostSpec;
    };

    users = lib.foldl (
      acc: userSpec:
      acc
      // {
        "${userSpec.username}" = {
          home.stateVersion = "25.05";

          imports = lib.flatten (
            lib.optional (!hostSpec.isMinimal) [
              (
                { ... }:

                {
                  config.userSpec = userSpec;
                  imports = [
                    ../../hosts/spec.nix
                    (lib.custom.relativeToRoot "hosts/users/${userSpec.username}.nix")
                  ];
                }
              )
            ]
          );
        };
      }
    ) { } hostSpec.users;
  };
}
