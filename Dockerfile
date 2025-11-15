ARG TYPESENSE_VERSION=0.25.2
FROM typesense/typesense:0.25.2

LABEL org.opencontainers.image.title="typesense-infra" \
      org.opencontainers.image.description="Typesense server with wrapper entrypoint" \
      org.opencontainers.image.version="${TYPESENSE_VERSION}"

ENV TYPESENSE_DATA_DIR=/data \
    TYPESENSE_ENABLE_CORS=true

# Create the data dir for Railway
RUN mkdir -p /data && chown -R 1000:1000 /data

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 8108

HEALTHCHECK --interval=10s --timeout=3s --retries=5 CMD wget -qO- http://127.0.0.1:8108/health | grep -q '"ok":true' || exit 1

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
