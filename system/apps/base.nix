{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nano
    os-prober
  ];
}