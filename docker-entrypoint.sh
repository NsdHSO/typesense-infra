#!/usr/bin/env sh
set -eu

# TYPESENSE_API_KEY is mandatory
: "${TYPESENSE_API_KEY?TYPESENSE_API_KEY is required}"

# Allow optional extra flags via TYPESENSE_EXTRA_FLAGS
EXTRA_FLAGS="${TYPESENSE_EXTRA_FLAGS:-}"

# Run the server. It listens on 0.0.0.0:8108 by default.
exec /opt/typesense-server \
  --data-dir /data \
  --api-key="${TYPESENSE_API_KEY}" \
  --enable-cors \
  ${EXTRA_FLAGS}