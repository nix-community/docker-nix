#!/bin/sh

curl https://nixos.org/nix-release.tt > release.tt

set -eux

getVal() {
  awk ' $1 == "'"$1"'" {print $3}' release.tt | sed 's/\"//g'
}

fetchNix() {
  curl "https://nixos.org/releases/nix/nix-$NIX_RELEASE/nix-$NIX_RELEASE-x86_64-linux.tar.xz"
}

NIX_RELEASE=$(getVal latestNixVersion)
NIX_HASH=$(fetchNix "$NIX_RELEASE" | sha256sum | cut -c1-64)

(
    echo "NIX_RELEASE=$NIX_RELEASE"
    echo "NIX_HASH=$NIX_HASH"
) > version.env
