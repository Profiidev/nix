{ config, lib, ... }:

{
  options.hostSpec = {
    hostname = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of the host";
    };
    isMinimal = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a minimal host";
    };
    users = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
        username = lib.mkOption {
          type = lib.types.str;
          description = "The username of the host";
        };
        home = lib.mkOption {
          type = lib.types.str;
          description = "The home directory of the user";
          default = null;
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
        ssh_config = lib.mkOption {
          type = lib.types.attrs;
          default = { };
          description = "User ssh config";
        };
        ssh_known_hosts = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "User ssh known hosts";
        };
        gpg_pub_key = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Public GPG Key for the user";
        };
        };
      });
      default = [];
      description = "Users for this host";
    };
  };
}
