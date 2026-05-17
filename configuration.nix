{ ... } : {
  imports = [
    ./disk-layout.nix
  ];

  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.efi.canTouchEfiVariables = false;

  hardware.nvidia-jetpack.enable = true;
  hardware.nvidia-jetpack.som = "orin-nano"; # Other options include orin-agx, xavier-nx, and xavier-nx-emmc
  hardware.nvidia-jetpack.super = true;
  hardware.nvidia-jetpack.carrierBoard = "devkit";
  networking.hostName = "curiosity";

  interfaces.eth0 = {
    ipv4.addresses = [ {
      address = "192.168.1.65";
      prefixLength = 24;
    } ];
  };

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    # Allow the graphical user to login without password
    initialHashedPassword = "$y$j9T$yYHRDTwtfY2giEIzCJq8o/$wjkfKVb5v3/QlnMcqi1Zd16J9I1lLwDJ0/6YNMKWL//";
  };

  services.openssh.enable = true;

  users.users.nixos.openssh.authorizedKeys.keys = [
    # YOUR SSH PUB KEY HERE #
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpv4hyo6JLrJQ80rAIb0tQfNro323iyY4YwV/Dpvt88JlnzUGvX160NqTbKZnGkdSrJqtOvGya2aGhdnj/5Wi8PnFoV+E1kWSoyW0dVMEukWrR6pIEzoxEApQ12ROFqsCK9N6IWVB6JHlNH0sqglyQL025WE89OQZEJy2E4w2kAmuRZfYxhMWJkp7cFn7NefMh6YG1J6ZZ75lKcQN65wiJ2sH/d6ujFVS6cX98kU2qkibJ8BuyD83RYBl8U0SoiD1MLd7LqDYHkPEm68mJT/ewP7WgdPPoKuj2+YAKr8Z6DTtHzDW9oehIwxfNssum/ZuBqBKHcfCUPfz1TC8habuxIo5vhgcB/9o/424DPQDzWcdURbBrEw4Tx7Y3ykiyMJ4Z5QAL9RDac+mju7RvIyXt51kXChBSenEMhu7hzFcUIGaXEBnRlu8eaH2da6eebDWc2nEDhG4TU3sb4YA/P9QFdW+JCyS9t7D90UgjhIan3u0kNzzbsieiMc9DETy8sak="
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCkeQ0MSty9182D2XX5mqaN/NF9ijHh8G04BxOkEKM9ABLf0ytQBFDSjHONoYemQgaLRw+dMWW9tNuHC7/6I4PlEOSzJHBlWCjVDwC/D7koT4MhSJAKCFYVCOK4hvf6gf+MkZKaJcbTlNpDHje3WB//emoMvMfht1Eazl6nIUQSeI8GVSOQb8eWVDFHcQSzDAPZejce3McWs9Dl8ILFN123TDXq5n0qzukq0yi5O3U+DzUIXMG7A6V0vuZ1Juks4Jg7J+LBx2X3cLpJ5/s4Gm66DDPGoDmnQHXUFfVqwDq11LeNjl4lNxQxvnq4aamVItWy+pd52FsC/pWswx5M2PO/5hADUuO0RUpQzkvCg3kXGklZ8BdC5vP5j4y5TvT8LrIhEl8O+kqBcWTFonvyoSK8s7xyOZLOk5nzVep/qdnhOsyOMb8hM/xUhyPER4zxHZF9yAjBdyd2OYxqUh09x2zE/jhqYdplEv4Zw2Kt9bSzI1+2VR0lKzBRVW1D4yV96UW7xFKpFi5/1krZm23xG4lKZ7o6Tbv/4+3c6njljv3WiQuNBxligbU6qBXxgIqomDw0ZrZ18DXcXQ8oIuf0FrLerBQdk0H7BcQWcL+6DJOBml/yGi9U4jmw91fdSf1ZVIWx/f3H4yuXGD6EACJBMw5Sdqlzq1q6pMzQ0E0f/6r3rQ=="
  ];
  users.users.root.openssh.authorizedKeys.keys = [
    # YOUR SSH PUB KEY HERE #
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpv4hyo6JLrJQ80rAIb0tQfNro323iyY4YwV/Dpvt88JlnzUGvX160NqTbKZnGkdSrJqtOvGya2aGhdnj/5Wi8PnFoV+E1kWSoyW0dVMEukWrR6pIEzoxEApQ12ROFqsCK9N6IWVB6JHlNH0sqglyQL025WE89OQZEJy2E4w2kAmuRZfYxhMWJkp7cFn7NefMh6YG1J6ZZ75lKcQN65wiJ2sH/d6ujFVS6cX98kU2qkibJ8BuyD83RYBl8U0SoiD1MLd7LqDYHkPEm68mJT/ewP7WgdPPoKuj2+YAKr8Z6DTtHzDW9oehIwxfNssum/ZuBqBKHcfCUPfz1TC8habuxIo5vhgcB/9o/424DPQDzWcdURbBrEw4Tx7Y3ykiyMJ4Z5QAL9RDac+mju7RvIyXt51kXChBSenEMhu7hzFcUIGaXEBnRlu8eaH2da6eebDWc2nEDhG4TU3sb4YA/P9QFdW+JCyS9t7D90UgjhIan3u0kNzzbsieiMc9DETy8sak="
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCkeQ0MSty9182D2XX5mqaN/NF9ijHh8G04BxOkEKM9ABLf0ytQBFDSjHONoYemQgaLRw+dMWW9tNuHC7/6I4PlEOSzJHBlWCjVDwC/D7koT4MhSJAKCFYVCOK4hvf6gf+MkZKaJcbTlNpDHje3WB//emoMvMfht1Eazl6nIUQSeI8GVSOQb8eWVDFHcQSzDAPZejce3McWs9Dl8ILFN123TDXq5n0qzukq0yi5O3U+DzUIXMG7A6V0vuZ1Juks4Jg7J+LBx2X3cLpJ5/s4Gm66DDPGoDmnQHXUFfVqwDq11LeNjl4lNxQxvnq4aamVItWy+pd52FsC/pWswx5M2PO/5hADUuO0RUpQzkvCg3kXGklZ8BdC5vP5j4y5TvT8LrIhEl8O+kqBcWTFonvyoSK8s7xyOZLOk5nzVep/qdnhOsyOMb8hM/xUhyPER4zxHZF9yAjBdyd2OYxqUh09x2zE/jhqYdplEv4Zw2Kt9bSzI1+2VR0lKzBRVW1D4yV96UW7xFKpFi5/1krZm23xG4lKZ7o6Tbv/4+3c6njljv3WiQuNBxligbU6qBXxgIqomDw0ZrZ18DXcXQ8oIuf0FrLerBQdk0H7BcQWcL+6DJOBml/yGi9U4jmw91fdSf1ZVIWx/f3H4yuXGD6EACJBMw5Sdqlzq1q6pMzQ0E0f/6r3rQ=="
  ];

  services.getty.autologinUser = "nixos";

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  nixpkgs.config.allowUnfree = true;

  hardware.nvidia-container-toolkit.enable = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = [];

  # Enable GPU support - needed even for CUDA and containers
  hardware.graphics.enable = true;
}