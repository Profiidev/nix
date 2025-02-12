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

  users.user.${meta.username}.extraGroups = [ "docker" ];
}