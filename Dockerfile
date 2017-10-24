FROM numtide/nix

RUN nix-env -iA nixpkgs.openssh nixpkgs.gnused
RUN mkdir -p /var/empty /etc/ssh /root/.ssh
RUN chmod 0700 /root/.ssh
RUN cp $(dirname $(dirname $(readlink -f $(type -P sshd))))/etc/ssh/sshd_config /etc/ssh/sshd_config
RUN sed \
  -e "s|#PasswordAuthentication .*|PasswordAuthentication no|g" \
  -e "s|.*AuthorizedKeysFile .*|AuthorizedKeysFile /etc/ssh/authorized_keys|g" \
  -i /etc/ssh/sshd_config

COPY remote-builder.sh /remote-builder.sh

CMD ["/remote-builder.sh"]
