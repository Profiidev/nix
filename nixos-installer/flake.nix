{
  description = "Minimal NixOS configuration for bootstrapping systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;

      minimalSpecialArgs = {
        inherit inputs outputs;
        lib = nixpkgs.lib.extend (self: super: { custom = import ../lib { inherit (nixpkgs) lib; }; });
      };

      newConfig =
        name:
        (nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = minimalSpecialArgs;
          modules = [
            ./minimal-configuration.nix
            ../hosts/profiles/${name}/hardware-config.nix

            { networking.hostName = name; }
          ];
        });
    in
    {
      nixosConfigurations = {
        # host = newConfig "name" disk" "swapSize" "useLuks"
        # Swap size is in GiB
        home = newConfig "home";
        laptop = newConfig "laptop";
      };
    };
}
