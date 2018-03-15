# Nix docker image

This improves on top of the nixos/nix image as it removes all Alpine Linux
dependencies.

## Usage

```Dockerfile
FROM nixorg/nix:latest

RUN nix-build -A pythonFull '<nixpkgs>'
```

## Update

Run `./update.sh`

## TODO

* /etc/passwd contains a lot of useless entries
