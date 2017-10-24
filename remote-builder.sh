#!/usr/bin/env bash
set -euo pipefail

echo Generate SSH host keys
ssh-keygen -q -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
ssh-keygen -q -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
ssh-keygen -q -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa -b 521
ssh-keygen -q -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519

echo "Install user's public SSH key"
echo $SSH_PUBLIC_KEY | tee /etc/ssh/authorized_keys

echo Starting sshd
$(type -P sshd) -ddd &

echo Starting nix-daemon
nix-daemon &

wait
