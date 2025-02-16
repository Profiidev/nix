{ config, lib, ... }:

{
  options.hostSpec = {
    # Host
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
    # User
    username = lib.mkOption {
      type = lib.types.str;
      description = "The username of the host";
    };
    git_user = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The git username";
    };
    git_email = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The git email";
    };
    git_sign_key = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "The git signing key";
    };
    ssh_keys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "User ssh keys";
    };
  };
}
