{ config, lib, ... }:

{
  options.hostSpec = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "The username of the host";
    };
    hostname = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of the host";
    };
    home = lib.mkOption {
      type = lib.types.str;
      description = "The home directory of the user";
      default = "/home/${config.hostSpec.username}";
    };
    isMinimal = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a minimal host";
    };
    ssh_keys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "User ssh keys";
    };
  };
}