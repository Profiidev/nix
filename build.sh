#!/bin/bash
sudo nix run github:nix-community/nixos-anywhere -- --flake .#home root@$1
