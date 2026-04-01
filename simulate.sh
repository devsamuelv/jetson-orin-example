# !/bin/bash

# Not configured for the jetson. Its just a default arm config
qemu-system-aarch64 \
  -machine virt,gic-version=max \
  -cpu max \
  -smp 4 \
  -m 8G \
  -drive file=QEMU_EFI.fd,format=raw,if=pflash,readonly=on \
  -drive file=vars.fd,format=raw,if=pflash \
  -cdrom ./result/iso/nixos-minimal-25.11.20260118.77ef7a2-aarch64-linux.iso \
  -boot d \
  -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
  -vga std