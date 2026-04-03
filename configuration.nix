{ jetpack, pkgs, ... } : {
  hardware.nvidia-jetpack.enable = true;
  hardware.nvidia-jetpack.som = "orin-nano"; # Other options include orin-agx, xavier-nx, and xavier-nx-emmc
  hardware.nvidia-jetpack.super = true;
  hardware.nvidia-jetpack.carrierBoard = "devkit";
  hardware.nvidia-jetpack.configureCuda = false;  # Disable CUDA config for cross-build
  networking.hostName = "curiosity";

  # boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nixpkgs.config.allowUnfree = true;

  hardware.nvidia-container-toolkit.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = [
    # pkgs.pkgsCross.aarch64-multiplatform.nvim
    # inputs.self.packages.aarch64-linux.main-program
  ];

  # Enable GPU support - needed even for CUDA and containers
  hardware.graphics.enable = true;
}