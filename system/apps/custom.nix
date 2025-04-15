{ config, pkgs, ... }: 

let
  shanocast = pkgs.callPackage ./custom/shanocast.nix {};
in
{
}