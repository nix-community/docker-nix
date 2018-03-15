#!/bin/sh

curl https://nixos.org/nix-release.tt > release.tt

set -eux

getVal() {
    cat release.tt \
        | awk ' $1 == "'"$1"'" {print $3}'
}

(
    echo "NIX_RELEASE=$(getVal latestNixVersion)"
    echo "NIX_HASH=$(getVal nix_hash_x86_64_linux)"
) > version.env
