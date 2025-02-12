#!/bin/bash
sudo nix build .#nixosConfigurations.$1-installer.config.system.build.isoImage
