# This Docker uses the multi-stage build feature of Docker.
# It kicks of the installation of Nix in a temporary alpine container,
# after which we copy the installation to an empty image that only contains Nix.

FROM alpine:3.10 as FETCHER

# Enable HTTPS support in wget.
RUN apk add --no-cache openssl ca-certificates

# Phase 0: bootstrap a nix installation
COPY ./phase0 .
RUN ./alpine-install.sh

# Phase 1: replace nix with the profile
ENV PATH=/nix/var/nix/profiles/default/bin:/usr/bin:/bin

COPY ./phase1 .

# Then replace the nix installation with the profile
RUN nix-build --option sandbox false profile.nix
RUN nix-env --profile /nix/var/nix/profiles/default --set $(readlink -f ./result)

# Remove old things
RUN \
  nix-channel --remove nixpkgs && \
  rm -rf /nix/store/*-nixpkgs* && \
  nix-collect-garbage -d && \
  nix-store --gc --option keep-derivations false

# Fixes the missing *-nixpkgs*
RUN nix-store --verify --check-contents

# Phase 2: and now ditch alpine
FROM scratch
COPY --from=FETCHER /nix /nix
COPY ./phase2 /

ENV \
    ENV=/nix/var/nix/profiles/default/etc/profile.d/nix.sh \
    PATH=/nix/var/nix/profiles/default/bin \
    PAGER=cat \
    GIT_SSL_CAINFO=/nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt \
    NIX_SSL_CERT_FILE=/nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt \
    NIX_PATH=/nix/var/nix/profiles/per-user/root/channels

RUN [ \
  "/nix/var/nix/profiles/default/bin/sh", \
  "-c", \
  "mkdir /bin && ln -s /nix/var/nix/profiles/default/bin/sh /bin/sh" \
]

RUN \
  mkdir -p /root /usr/bin && \
  mkdir --mode=1777 /tmp && \
  ln -s /nix/var/nix/profiles/default /root/.nix-profile && \
  ln -s /nix/var/nix/profiles/default/bin/env /usr/bin/env && \
  ln -s /nix/var/nix/profiles/default/etc/protocols /etc/protocols && \
  ln -s /nix/var/nix/profiles/default/etc/services /etc/services && \
  ln -s /nix/var/nix/profiles/default/etc/ssl /etc/ssl && \
  ln -sf /nix/var/nix/profiles/default/bin/sh /bin/sh && \
  true

CMD ["bash"]
