{
  description = "Minimal NixOS configuration for bootstrapping systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    disko.url =
      "github:nix-community/disko"; # Declarative partitioning and formatting
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;

      minimalSpecialArgs = {
        inherit inputs outputs;
        lib = nixpkgs.lib.extend
          (self: super: { custom = import ../lib { inherit (nixpkgs) lib; }; });
      };

      newConfig = name: disk: swapSize: useLuks:
        (let
          diskSpecPath = if useLuks then
            ../hosts/disks/btrfs-luks.nix
          else
            ../hosts/disks/btrfs.nix;
        in nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = minimalSpecialArgs;
          modules = [
            inputs.disko.nixosModules.disko
            diskSpecPath
            {
              _module.args = {
                inherit disk;
                withSwap = swapSize > 0;
                swapSize = builtins.toString swapSize;
              };
            }
            ./minimal-configuration.nix
            ../hosts/profiles/${name}/hardware-config.nix

            { networking.hostName = name; }
          ];
        });
    in {
      nixosConfigurations = {
        # host = newConfig "name" disk" "swapSize" "useLuks"
        # Swap size is in GiB
        home = newConfig "home" "/dev/sda" 4 true;
      };
    };
}
