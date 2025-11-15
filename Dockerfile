# Build custom Typesense image for Railway
FROM typesense/typesense:0.25.2

# Environment defaults
ENV TYPESENSE_DATA_DIR=/data \
    TYPESENSE_ENABLE_CORS=true \
    TYPESENSE_NUM_THREADS=8

# Copy entrypoint
RUN mkdir -p /data && chown -R 1000:1000 /data
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 8108

HEALTHCHECK --interval=10s --timeout=3s --retries=5 \
  CMD wget -qO- http://127.0.0.1:8108/health | grep -q '"ok":true' || exit 1

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
