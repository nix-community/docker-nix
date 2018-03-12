FROM numtide/nix as BUILD

COPY . /src

RUN /src/build-and-prune.sh

FROM scratch
COPY --from=BUILD /bin /bin
COPY --from=BUILD /etc/group /etc/group
COPY --from=BUILD /etc/passwd /etc/passwd
COPY --from=BUILD /etc/shadow /etc/shadow
COPY --from=BUILD /new-nix /nix
COPY --from=BUILD /root /root
COPY --from=BUILD /tmp /tmp
