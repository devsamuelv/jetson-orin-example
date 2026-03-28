{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    jetpack.url = "github:anduril/jetpack-nixos/db526542891c9d4e49a5a7ccb7e4e59dfc8d5162"; # Add this line
    jetpack.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, jetpack, ... } : { # Add jetpack
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [./configuration.nix jetpack.nixosModules.default]; # Add jetpack.nixosModules.default
    };
  };
}
