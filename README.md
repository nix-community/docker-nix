# Alpine + Nix docker image

This improves on top of the nixos/nix image.

Longer term the goal is to generate a pure NixOS image, but for now let's just
fix the common issues that the nixos/nix image is having like the missing CA
certificates.

## Usage

```Dockerfile
FROM numtide/nix:1.11

RUN \
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs && \
  nix-channel --update

RUN nix-build -A pythonFull '<nixpkgs>'
```
