{ pkgs, meta, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    lazydocker
  ];

  users.users.${meta.username}.extraGroups = [ "docker" ];
}