# Minimal Typesense server image for Railway (port 8108)
# Uses official Typesense image and a small wrapper to inject the API key from env
FROM typesense/typesense:0.25.2

# Wrapper entrypoint that passes --api-key from $TYPESENSE_API_KEY
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Typesense listens on 8108 by default
EXPOSE 8108

# Do NOT declare VOLUME here; let the platform (Railway) manage persistence at /data
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
