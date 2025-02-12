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

    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, disko, ... }@inputs: let
    home-manager = inputs.home-manager;

    systems = [
      { 
        name = "home"; 
        hostname = "nix"; 
        username = "profidev"; 
      }
    ];
  in {
    nixosConfigurations = builtins.listToAttrs(map (meta: {
      name = meta.name;
      value = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit meta;
          inherit inputs;
        };
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./disko-config.nix
          (./. + "/profiles" + ("/" + meta.name) + "/config.nix")
        ];
      };
    }) systems);

    homeConfigurations = builtins.listToAttrs(map (meta: {
      name = meta.name;
      value = home-manager.lib.homeManagerConfiguration {
        modules = [
          (./. + "/profiles" + ("/" + meta.name) + "/home.nix")
        ];

        extraSpecialArgs = {
          inherit meta;
        };
      };
    }) systems);
  };
}
