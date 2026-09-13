{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    dbeaver-bin
    postman
    wireshark
  ];
}
