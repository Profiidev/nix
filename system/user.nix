{ inputs, pkgs, config, lib, host, ... }:

let 
  hostSpec = config.hostSpec;
  pubKeys = lib.filesystem.listFilesRecursive ../keys;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  sopsHashedPasswordFile = lib.optionalString (
    !config.hostSpec.isMinimal
  ) config.sops.secrets."passwords/${hostSpec.username}".path;
in
{
  users.users.${hostSpec.username} = {
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

    openssh.authorizedKeys.keys = lib.lists.forEach pubKeys (key: builtins.readFile key);
  };

  # Create ssh sockets directory for controlpaths when homemanager not loaded (i.e. isMinimal)
  systemd.tmpfiles.rules =
    let
      user = config.users.users.${hostSpec.username}.name;
      group = config.users.users.${hostSpec.username}.group;
    in
    # you must set the rule for .ssh separately first, otherwise it will be automatically created as root:root and .ssh/sockects will fail
    [
      "d /home/${hostSpec.username}/.ssh 0750 ${user} ${group} -"
      "d /home/${hostSpec.username}/.ssh/sockets 0750 ${user} ${group} -"
    ];

  programs.git.enable = true;
  environment.systemPackages = [
    pkgs.just
    pkgs.rsync
  ];
}
//
lib.optionalAttrs (inputs ? "home-manager") {
  home-manager = {
    extraSpecialArgs = {
      inherit pkgs inputs;
      hostSpec = config.hostSpec;
    };

    users.${hostSpec.username} = {
      home.stateVersion = "24.11";

      imports = lib.flatten (
        lib.optional (!hostSpec.isMinimal) [
          (
            { config, ... }:
            import (lib.custom.relativeToRoot "hosts/profiles/${host}/home.nix") {
              inherit
                pkgs
                inputs
                config
                lib
                hostSpec
                host
                ;
            }
          )
        ]
      );
    };
  };
}