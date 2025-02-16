{ config, ... }:

let userSpec = config.userSpec;
in {
  # Create ssh sockets directory for controlpaths when homemanager not loaded (i.e. isMinimal)
  systemd.tmpfiles.rules = let
    user = config.users.users.${userSpec.username}.name;
    group = config.users.users.${userSpec.username}.group;
    # you must set the rule for .ssh separately first, otherwise it will be automatically created as root:root and .ssh/sockects will fail
  in [
    "d /home/${userSpec.username}/.ssh 0750 ${user} ${group} -"
    "d /home/${userSpec.username}/.ssh/sockets 0750 ${user} ${group} -"
  ];
}
