#!/usr/bin/env bash
set -euxo pipefail

root=$(nix-build /src/ci.nix --no-out-link)
all_drvs=($(nix-store --query -R "$root"))

# copy to /new-nix
mkdir -p /new-nix/store
cp "${all_drvs[@]}" /new-nix/store

# symlink to /bin
rm -rf /bin
ln -s "$root/bin" /bin
