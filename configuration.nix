{ ... } : {
  # Just set these options to make the toplevel system evaluate without assertion errors
  fileSystems."/".fsType = "tmpfs";
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = false;

  hardware.nvidia-jetpack.enable = true;
  hardware.nvidia-jetpack.som = "orin-nano"; # Other options include orin-agx, xavier-nx, and xavier-nx-emmc
  hardware.nvidia-jetpack.super = true;
  hardware.nvidia-jetpack.carrierBoard = "devkit";
  hardware.nvidia.datacenter.enable = true;
  hardware.nvidia-jetpack.configureCuda = false;  # Disable CUDA config for cross-build
  networking.hostName = "curiosity";

  services.create_ap = {
    enable = true;
    settings = {
      INTERNET_IFACE = "eth0"; # Your internet-connected interface
      WIFI_IFACE = "wlan0";    # Your wireless interface
      SSID = "My Wifi Hotspot";
      PASSPHRASE = "12345678";
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

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