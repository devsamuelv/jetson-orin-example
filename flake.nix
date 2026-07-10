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
  flake-utils.lib.eachDefaultSystem (system: 
    let 
      pkgs = (import nixpkgs {
        inherit system;
       });

      crossPkgs = import nixpkgs {
        inherit system;
        crossSystem.config = "aarch64-unknown-linux-gnu"; 
      };
    in { # Add jetpack
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
          ./hardware-configuration.nix
          jetpack.nixosModules.default

          ({ self, ... }: {
            nixpkgs.overlays = [
              (final: prev: {
                test = self.packages.x86_64-linux.test;
              })
            ];
          })
        ]; # Add jetpack.nixosModules.default
      };

      packages.test = with pkgs.clangStdenv;
        mkDerivation {
          pname = "jetson-example";
          version = "1.0.0";
          src = ./.;
          buildInputs = [ pkgs.gtk2 pkgs.cmake pkgs.makeWrapper ];

          buildPhase = ''
            mkdir -p build
            cmake -S $src -B ./build -DCMAKE_BUILD_TYPE=Debug
            cmake --build build
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp build/jetson-example $out/bin
          '';
        };

        packages.test_arm = with crossPkgs.clangStdenv;
        mkDerivation {
          pname = "jetson-example";
          version = "1.0.0";
          src = ./.;
          buildInputs = [ crossPkgs.gtk2 crossPkgs.cmake ];
          nativeBuildInputs = [crossPkgs.makeWrapper];

          buildPhase = ''
            mkdir -p build
            cmake -S $src -B ./build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE="cmake/toolchain-arm.cmake"
            cmake --build build
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp build/jetson-example $out/bin
          '';
        };
  });
}
