{
  description = "Nixos config flake";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nix-citizen.cachix.org"
      "http://192.168.178.22:5000"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
      "profidev.cachix.org:tg4xEn64UMdvA5jJYT8omo/CQHk8+spLyeGT2YAku70="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";

    keyring-unlocker-src = {
      url = "github:recolic/gnome-keyring-yubikey-unlock";
      flake = false;
    };

    nix-secrets = {
      url = "git+ssh://git@github.com/ProfiiDev/nix-secrets.git?ref=main&shallow=1";
      inputs = { };
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    nix-citizen = {
      url = "github:LovingMelody/nix-citizen";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nix-gaming.follows = "nix-gaming";
        flake-parts.follows = "flake-parts";
      };
    };

    proton = {
      url = "github:profiidev/proton/latest";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        rust-overlay.follows = "rust-overlay";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      ...
    }:
    let
      inherit (nixpkgs) lib;
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs host;
              lib = nixpkgs.lib.extend (
                self: super: {
                  custom = import ./lib { inherit (nixpkgs) lib; };
                }
              );
              pkgsUnstable = import nixpkgs-unstable {
                config = {
                  allowUnfree = true;
                  allowUnfreePredicate = _: true;
                };
              };
              pkgsUnstableCuda = import nixpkgs-unstable {
                config = {
                  allowUnfree = true;
                  allowUnfreePredicate = _: true;
                  cudaSupport = true;
                };
              };
            };
            modules = [ ./hosts/profiles/${host} ];
          };
        }) (lib.attrNames (builtins.readDir ./hosts/profiles))
      );
    };
}
