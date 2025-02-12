{ meta, ... }:

{
  user.user.${meta.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "$y$j9T$halYxhBlpG0WwEVppW5Fg/$RToHC2VXnnVDN5fFjRklQo4A9vzStUhSAvQO5KRC/3B";
  };

  users.users.root = {
    hashedPassword = "$y$j9T$halYxhBlpG0WwEVppW5Fg/$RToHC2VXnnVDN5fFjRklQo4A9vzStUhSAvQO5KRC/3B";
  };
}