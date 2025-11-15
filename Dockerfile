# --------
# Build Args
# --------
ARG TYPESENSE_VERSION=0.25.2

# --------
# Base Image
# --------
FROM typesense/typesense:${TYPESENSE_VERSION}

# --------
# Metadata
# --------
LABEL org.opencontainers.image.title="typesense-infra" \
      org.opencontainers.image.description="Typesense server with wrapper entrypoint" \
      org.opencontainers.image.version="${TYPESENSE_VERSION}"

# --------
# Environment
# --------
ENV TYPESENSE_DATA_DIR=/data \
    TYPESENSE_ENABLE_CORS=true

# --------
# Ensure /data exists for Railway or any platform
# --------
RUN mkdir -p /data \
    && chown -R 1000:1000 /data

# --------
# Copy custom entrypoint
# --------
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# --------
# Expose port
# --------
EXPOSE 8108

# --------
# Healthcheck
# --------
HEALTHCHECK --interval=10s --timeout=3s --retries=5 \
  CMD wget -qO- http://127.0.0.1:8108/health | grep -q '"ok":true' || exit 1

# --------
# Entrypoint
# --------
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
