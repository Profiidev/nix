{ ... }:

{
  services.nix-serve = {
    enable = true;
    secretKeyFile = "/etc/nix/key.private";
  };
}
