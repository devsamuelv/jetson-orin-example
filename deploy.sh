# !/bin/bash

# Maybe use jq to handle json data in bash?
nixos-rebuild switch --flake .#nixos \
  --target-host nixos@192.168.1.35 --build-host localhost --verbose