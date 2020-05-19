# Nix docker image

**STATUS: Deprecated**: see https://github.com/nix-community/docker-nixpkgs

This improves on top of the nixos/nix image as it removes all Alpine Linux
dependencies.

The image doesn't contain any channels to reduce the default image size and
encourage users to fully pin their dependency set.

## Usage

```Dockerfile
FROM nixorg/nix:latest
RUN nix run -f channel:nixos-18.03 hello -c hello
```

### CircleCI

CircleCI assumes that git and openssh are available in the container to clone the repository. This is out of our control and we therefor cannot rely on nix-shell to pull in these dependencies.

Another image at `nixorg/nix:circleci` is published that contains these additional dependencies.

This branch is regularily rebased on top of master.

## Update

The `./update.sh` script is used to get the latest nix release.

## TODO

* /etc/passwd contains a lot of useless entries

# See also

* nixos/nix: published from the nixos/nix repo
* lnl7/nix: https://github.com/LnL7/nix-docker
