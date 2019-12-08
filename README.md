# Nix docker image

This improves on top of the nixos/nix image as it removes all Alpine Linux
dependencies.

The image doesn't contain any channels to reduce the default image size and
encourage users to fully pin their dependency set.

## Usage

```Dockerfile
FROM nixorg/nix:2
RUN nix run -f channel:nixos-18.03 hello -c hello
```

## Update

The `./update.sh` script is used to get the latest nix release.

## TODO

* /etc/passwd contains a lot of useless entries

# See also

* nixos/nix: published from the nixos/nix repo
* lnl7/nix: https://github.com/LnL7/nix-docker
