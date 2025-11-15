# Minimal Typesense server image (port 8108)
# - Version pinned, labels added
# - Healthcheck for readiness
# - Wrapper entrypoint passes API key and opts from env

ARG TYPESENSE_VERSION=0.25.2
FROM typesense/typesense:0.25.2

LABEL org.opencontainers.image.title="typesense-infra" \
      org.opencontainers.image.description="Typesense server with wrapper entrypoint for platforms like Railway" \
      org.opencontainers.image.source="https://example.local/infra/typesense-infra" \
      org.opencontainers.image.version="${TYPESENSE_VERSION}"

# Defaults (can be overridden at runtime)
ENV TYPESENSE_DATA_DIR=/data \
    TYPESENSE_ENABLE_CORS=true

# Wrapper entrypoint that passes --api-key from $TYPESENSE_API_KEY
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Typesense listens on 8108 by default
EXPOSE 8108

# Simple healthcheck against /health (no auth required)
HEALTHCHECK --interval=10s --timeout=3s --retries=5 CMD wget -qO- http://127.0.0.1:8108/health | grep -q '"ok":true' || exit 1

# Do NOT declare VOLUME here; let the platform manage persistence at /data
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
