{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.aurora ];
  # lets the logged-in user open phones in USB accessory mode
  services.udev.packages = [ pkgs.aurora ];
}
