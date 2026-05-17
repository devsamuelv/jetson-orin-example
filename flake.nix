{
  description = "A very basic flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    jetpack.url = "github:anduril/jetpack-nixos/db526542891c9d4e49a5a7ccb7e4e59dfc8d5162"; # Add this line
    jetpack.inputs.nixpkgs.follows = "nixpkgs";

    disko.inputs.nixpkgs.follows = "nixpkgs";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
  };

  outputs = inputs@{ self, nixpkgs, jetpack, flake-utils, disko, nixos-facter-modules, ... } : 
    let 
      pkgs = (import nixpkgs { });
    in { # Add jetpack
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
          ./hardware-configuration.nix
          jetpack.nixosModules.default
        ]; # Add jetpack.nixosModules.default
      };
  };
}
