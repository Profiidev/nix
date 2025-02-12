{ meta, ... }:

{
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.${meta.username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAIhx5NYVh5L6t9Vo4F9hvNYAyj4KslBJo96L9k39zQh u0_a321@localhost"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJVWNfJFz2uvoxPFHTHxN57W5GU49Nfvqa0scPSxROEy profidev@desktop-n5z690"
  ];
}