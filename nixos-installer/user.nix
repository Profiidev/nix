{ config, ... }:

{
  users.users = lib.mkMerge [(map (spec: {
    "${config.spec.username}" = {
    isNormalUser = true;
    hashedPassword =
      "$y$j9T$halYxhBlpG0WwEVppW5Fg/$RToHC2VXnnVDN5fFjRklQo4A9vzStUhSAvQO5KRC/3B";
    extraGroups = [ "wheel" ];
    };
    }) config.hostSpec.users)];
}
