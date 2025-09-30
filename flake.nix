{
  description = "Nixos config flake";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nix-citizen.cachix.org"
      "https://profidev.cachix.org"
      "http://192.168.178.22:5000"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
      "profidev.cachix.org-1:xdwadal2vlCD50JtDTy8NwjOJvkOtjdjy1y91ElU9GE="
      "profidev.cachix.org:tg4xEn64UMdvA5jJYT8omo/CQHk8+spLyeGT2YAku70="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    proton = {
      url = "github:profiidev/proton/latest";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
      };
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      nix-darwin,
      ...
    }:
    let
      specialArgs = pkgs: {
        inherit inputs self;
        lib = pkgs.lib.extend (
          self: super: {
            custom = import ./lib { inherit (pkgs) lib; };
          }
        );
        pkgsStable = import nixpkgs {
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
          };
        };
        pkgsUnstableNoCuda = import nixpkgs-unstable {
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
          };
        };
      };

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems =
        f: nixpkgs-unstable.lib.genAttrs supportedSystems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (
        pkgs:
        builtins.listToAttrs (
          map
            (pkg: {
              name = pkg;
              value = pkgs.callPackage ./packages/${pkg}.nix { };
            })
            (
              builtins.filter (pkg: pkg != "overlay") (
                map (pkg: pkgs.lib.removeSuffix ".nix" pkg) (builtins.attrNames (builtins.readDir ./packages))
              )
            )
        )
      );

      nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = nixpkgs-unstable.lib.nixosSystem {
            specialArgs = specialArgs nixpkgs-unstable // {
              inherit host;
              isLinux = true;
            };
            modules = [ ./hosts/profiles/${host} ];
          };
        }) (nixpkgs-unstable.lib.attrNames (builtins.readDir ./hosts/profiles))
      );

      # https://nix-darwin.github.io/nix-darwin/manual/index.html
      darwinConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = nix-darwin.lib.darwinSystem {
            specialArgs = specialArgs nixpkgs-unstable // {
              inherit host;
              isLinux = false;
            };
            modules = [ ./hosts/mac/${host} ];
          };
        }) (nixpkgs.lib.attrNames (builtins.readDir ./hosts/mac))
      );
    };
}
