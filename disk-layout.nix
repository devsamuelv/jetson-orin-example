# Example to create a bios compatible gpt partition
{ lib, ... }:
{
  disko.devices = {
    disk.disk1 = {
      device = lib.mkDefault "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            start = "1M";
            end = "512M";
            type = "EF02";
          };
          root = {
            name = "root";
            start = "512M";
            end = "-8GB";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
          plainSwap = {
            start = "8GB";
            end = "100%";
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true; # resume from hiberation from this device
            };
          };
        };
      };
    };
  };
}