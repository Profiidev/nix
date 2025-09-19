{
  lib,
  config,
  inputs,
  pkgs,
  pkgsUnstable,
  pkgsUnstableCuda,
  isDarwin,
  ...
}:

let
  hostSpec = config.hostSpec;
  pubKeys = lib.filesystem.listFilesRecursive ../../keys;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;

  platform = if isDarwin then "darwin" else "nixos";
  platformModules = "${platform}Modules";
  isLinux = pkgs.stdenv.isLinux;
in
{
  imports = [
    inputs.home-manager.${platformModules}.home-manager
  ];

  users = {
    users = lib.foldl (
      acc: spec:
      acc
      // {
        "${spec.username}" = {
          openssh.authorizedKeys.keys = lib.lists.forEach pubKeys (key: builtins.readFile key);
        }
        // (
          if isLinux then
            {
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
            }
          else
            {
              home = "/Users/${spec.username}";
            }
        );
      }
    ) { } hostSpec.users;
  }
  // (
    if isLinux then
      {
        mutableUsers = false;
      }
    else
      { }
  );

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
