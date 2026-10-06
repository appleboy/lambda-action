FROM ghcr.io/appleboy/drone-lambda@sha256:07cf67c4c0b647f2f79e444db446d88d332a8a0b0d3aaf8753692e6f7792a7cf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
