{ inputs, ... }:

{
  imports = [
    ./hardware-config.nix

    ../../spec.nix

    # Base
    ../../../modules/sops.nix
    ../../../modules/users/normal.nix
    # Profiles

    ../../../modules/profiles/apps/base.nix
    ../../../modules/apps/code_editor.nix
  ];

  hostSpec = {
    hostname = "work";
    users = [
      inputs.nix-secrets.users.work
    ];
  };
}
