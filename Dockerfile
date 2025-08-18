FROM harbor.budapest.hu/docker-hub/fphgov/helm:3.17.3

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
