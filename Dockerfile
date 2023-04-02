FROM ghcr.io/appleboy/drone-lambda:1.3.5

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
