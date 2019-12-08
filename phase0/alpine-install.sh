#!/bin/sh
# Installs nix in archlinux
set -eux
set -o pipefail
# shellcheck disable=SC1091
. ./version.env

wget -O- "https://nixos.org/releases/nix/nix-$NIX_RELEASE/nix-$NIX_RELEASE-x86_64-linux.tar.xz" > nix.tar.xz
actual_hash="$(sha256sum -b nix.tar.xz | cut -c1-64)"


if [ "$NIX_HASH" != "$actual_hash" ]; then
    echo "SHA-256 hash mismatch; expected $NIX_HASH, got $actual_hash"
    exit 1
fi

tar -xJvf nix.tar.xz

addgroup -g 30000 -S nixbld

for i in $(seq 1 30); do
    adduser -S -D -h /var/empty -g "Nix build user $i" -u $((30000 + i)) -G nixbld "nixbld$i"
done

mkdir -m 0755 /nix

USER=root sh nix-*-x86_64-linux/install
