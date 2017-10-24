# nix-remote-builder

Start a SSH daemon and nix-daemon into the container.

On boot, provision with the SSH public key of the host and start all of the things.

## Usage

```
docker run -ti --rm -p -e SSH_PUBLIC_KEY=$(~/.ssh/id_rsa.pub) -p 2022:22 numtide/nix:remote-builder
```
