{
  description = "A very basic flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    jetpack.url = "github:anduril/jetpack-nixos/db526542891c9d4e49a5a7ccb7e4e59dfc8d5162"; # Add this line
    jetpack.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, jetpack, flake-utils, ... } : 
    let pkgs = (import nixpkgs {}); in { # Add jetpack
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "aarch64-linux";
      modules = [
        ./configuration.nix jetpack.nixosModules.default
      ]; # Add jetpack.nixosModules.default
    };
    
    packages.aarch64-linux.main-program = with pkgs.pkgsCross.aarch64-multiplatform.clangStdenv; rec {
      pname = "main-program";
      version = "1.0.0";
      src = ./.;

      nativeBuildInputs = [
        cmake
        makeWrapper
      ];
    };
  };
}
