# Nix docker image

This improves on top of the nixos/nix image as it removes all Alpine Linux
dependencies.

## Usage

```Dockerfile
FROM numtide/nix:1.11

RUN nix-build -A pythonFull '<nixpkgs>'
```
