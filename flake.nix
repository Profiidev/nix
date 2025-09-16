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
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-citizen = {
      url = "github:LovingMelody/nix-citizen";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nix-gaming.follows = "nix-gaming";
      };
    };

    proton = {
      url = "github:profiidev/proton/latest";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib;
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = nixpkgs.lib.nixosSystem {
            specialArgs =
              let
                system = "x86_64-linux";
              in
              {
                inherit inputs outputs host;
                lib = nixpkgs.lib.extend (
                  self: super: {
                    custom = import ./lib { inherit (nixpkgs) lib; };
                  }
                );
                pkgsUnstable = import nixpkgs-unstable {
                  inherit system;
                  config = {
                    allowUnfree = true;
                    allowUnfreePredicate = _: true;
                  };
                };
                pkgsUnstableCuda = import nixpkgs-unstable {
                  inherit system;
                  config = {
                    allowUnfree = true;
                    allowUnfreePredicate = _: true;
                    cudaSupport = true;
                  };
                };
              };
            modules = [ ./hosts/profiles/${host}/config.nix ];
          };
        }) (lib.attrNames (builtins.readDir ./hosts/profiles))
      );
    };
}
