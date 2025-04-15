{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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

    keyring-unlocker-src = {
      url = "github:recolic/gnome-keyring-yubikey-unlock";
      flake = false;
    };

    nix-secrets = {
      url =
        "git+ssh://git@github.com/ProfiiDev/nix-secrets.git?ref=master&shallow=1";
      inputs = { };
    };

    shanocast = {
      url = "github:rgerganov/shanocast";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;
    in {
      nixosConfigurations = builtins.listToAttrs (map (host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs host;
            lib = nixpkgs.lib.extend (self: super: {
              custom = import ./lib { inherit (nixpkgs) lib; };
            });
          };
          modules = [ ./hosts/profiles/${host}/config.nix ];
        };
      }) (lib.attrNames (builtins.readDir ./hosts/profiles)));
    };
}
