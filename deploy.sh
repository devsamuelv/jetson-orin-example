# !/bin/bash

# Maybe use jq to handle json data in bash?
nixos-rebuild switch --flake .#my-nixos \
  --target-host root@192.168.4.1 --build-host localhost --verbose