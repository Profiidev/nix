{ config, ... }:

let
  hostSpec = config.hostSpec;
in
{
  # Create ssh sockets directory for controlpaths when homemanager not loaded (i.e. isMinimal)
  systemd.tmpfiles.rules =
    let
      user = config.users.users.${hostSpec.username}.name;
      group = config.users.users.${hostSpec.username}.group;
    in
    # you must set the rule for .ssh separately first, otherwise it will be automatically created as root:root and .ssh/sockects will fail
    [
      "d /home/${hostSpec.username}/.ssh 0750 ${user} ${group} -"
      "d /home/${hostSpec.username}/.ssh/sockets 0750 ${user} ${group} -"
    ];
}