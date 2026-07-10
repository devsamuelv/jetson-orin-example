# !/bin/bash

if [ -z "$DEPLOY_HOST" ]; then
  echo 'Please define DEPLOY_HOST by doing: export DEPLOY_HOST="device-ip";'
else 
  # Maybe use jq to handle json data in bash?
  nixos-rebuild switch --flake .#nixos \
    --target-host nixos@$DEPLOY_HOST --build-host localhost --verbose
fi