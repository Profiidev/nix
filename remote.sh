#!/bin/bash
sudo rm -rf result/iso
sudo nix run github:nix-community/nixos-anywhere -- --flake .#$1 root@$2
