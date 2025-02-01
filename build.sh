#!/bin/bash

sudo nix shell nixpkgs#nixos-generators --command nixos-generate --flake .#home -f iso -o out