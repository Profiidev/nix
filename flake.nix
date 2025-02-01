{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, ... }@inputs: let
    systems = [
      { name = "home"; hostname = "nix"; }
    ];
  in {
    nixosConfigurations = builtins.listToAttrs(map (device: {
      name = device.name;
      value = nixpkgs.lib.nixosSystem {
        specialArgs = {
          meta = {
            hostname = device.hostname;
          };
        };
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./config.nix
          ./hardware-config.nix
          ./disko-config.nix
        ];
      };
    }) systems);
  };
}
