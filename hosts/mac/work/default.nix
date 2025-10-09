{ inputs, pkgs, ... }:

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
    ../../../modules/apps/terminal.nix
    ../../../modules/system/services/font.nix
  ];

  environment.systemPackages = with pkgs; [
    gemini-cli
  ];

  hostSpec = {
    hostname = "work";
    users = [
      inputs.nix-secrets.users.work
    ];
    configPath = "/etc/nix-darwin/nix-config";
  };
}
