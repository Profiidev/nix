{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    dbx-desktop
    postman
    wireshark
  ];
}
