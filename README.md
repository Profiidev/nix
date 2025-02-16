# Nix Config

Inspired from https://github.com/EmergentMind/nix-config
Home manager Options: https://rycee.gitlab.io/home-manager/options.xhtml

  fontProfiles = {
    enable = true;
    monospace = {
      family = "FiraCode Nerd Font Mono";
      package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
    };
    regular = {
      family = "Fira Sans";
      package = pkgs.fira;
    };
  };
