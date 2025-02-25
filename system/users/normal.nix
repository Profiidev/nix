{ lib, config, inputs, pkgs, host, ... }:

let
  hostSpec = config.hostSpec;
  pubKeys = lib.filesystem.listFilesRecursive ../../keys;
  ifTheyExist = groups:
    builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users = lib.foldl (acc: spec:
    acc // {
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
          ])
        ];
        hashedPasswordFile = lib.mkIf (!hostSpec.isMinimal)
          config.sops.secrets."passwords/${spec.username}".path;

        openssh.authorizedKeys.keys =
          lib.lists.forEach pubKeys (key: builtins.readFile key);
      };
    }) { } hostSpec.users;
} // lib.optionalAttrs (inputs ? "home-manager") {
  home-manager = {
    extraSpecialArgs = {
      inherit pkgs inputs;
      hostSpec = config.hostSpec;
    };

    users = lib.foldl (acc: userSpec:
      acc // {
        "${userSpec.username}" = {
          home.stateVersion = "25.05";

          imports = lib.flatten (lib.optional (!hostSpec.isMinimal) [
            ({ config, ... }:

              {
                config.userSpec = userSpec;
                imports = [
                  ../../hosts/spec.nix
                  (lib.custom.relativeToRoot
                    "hosts/users/${userSpec.username}.nix")
                ];
              })
          ]);
        };
      }) { } hostSpec.users;
  };
}
