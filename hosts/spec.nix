# Specifications For Differentiating Hosts
{
  config,
  pkgs,
  lib,
  ...
}:
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
    # FIXME(hostSpec): This should probably just switch to an impermenance option?
    persistFolder = lib.mkOption {
      type = lib.types.str;
      description = "The folder to persist data if impermenance is enabled";
      default = "/persist";
    };
    isMinimal = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a minimal host";
    };
    isProduction = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Used to indicate a production host";
    };
    useYubikey = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate if the host uses a yubikey";
    };
    hdr = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Used to indicate a host that uses HDR";
    };
    scaling = lib.mkOption {
      type = lib.types.str;
      default = "1";
      description = "Used to indicate what scaling to use. Floating point number";
    };
  };
}