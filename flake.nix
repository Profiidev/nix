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

    nix-secrets = {
      url = "git+ssh://git@github.com/ProfiiDev/nix-secrets.git?ref=master&shallow=1";
      inputs = { };
    };
  };

  outputs = { self, nixpkgs, disko, ... }@inputs: let
    systems = [
      { 
        name = "home"; 
        hostname = "nix"; 
        username = "profidev"; 
      }
      {
        name = "iso";
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
          lib = nixpkgs.lib.extend (self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; });
        };
        system = "x86_64-linux";
        modules = [
          (./. + "/hosts/profiles" + ("/" + meta.name) + "/config.nix")
        ];
      };
    }) systems);
  };
}
