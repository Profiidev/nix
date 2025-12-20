{
  description = "Nixos config flake";

  nixConfig = {
    extra-substituters = [
      "https://cache.garnix.io"
      "https://nix-community.cachix.org"
      "https://nix-citizen.cachix.org"
      "https://profidev.cachix.org"
      "https://hyprland.cachix.org"
      "http://192.168.178.22:5000"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
      "profidev.cachix.org-1:xdwadal2vlCD50JtDTy8NwjOJvkOtjdjy1y91ElU9GE="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
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
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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
        nixpkgs.follows = "nixpkgs-unstable";
        flake-parts.follows = "flake-parts";
      };
    };

    nix-citizen = {
      url = "github:LovingMelody/nix-citizen";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        nix-gaming.follows = "nix-gaming";
        flake-parts.follows = "flake-parts";
      };
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    bun2nix = {
      url = "github:baileylutcd/bun2nix?rev=72c047583edc83e2c2eada6e348dfaa622781331";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      nix-darwin,
      bun2nix,
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
      };

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems =
        f:
        nixpkgs-unstable.lib.genAttrs supportedSystems (
          system: f nixpkgs-unstable.legacyPackages.${system}
        );
    in
    {
      packages = forAllSystems (
        pkgs:
        builtins.listToAttrs (
          map
            (pkg: {
              name = pkg;
              value = pkgs.callPackage ./packages/${pkg}.nix {
                mkBunDerivation = bun2nix.lib.${pkgs.stdenv.hostPlatform.system}.mkBunDerivation;
              };
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
