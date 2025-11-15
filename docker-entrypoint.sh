#!/usr/bin/env sh
set -eu

: "${TYPESENSE_API_KEY?TYPESENSE_API_KEY is required}"

EXTRA_FLAGS="${TYPESENSE_EXTRA_FLAGS:-}"

exec /opt/typesense-server \
  --data-dir /data \
  --api-key="${TYPESENSE_API_KEY}" \
  --enable-cors \
  --num-threads="${TYPESENSE_NUM_THREADS:-8}" \
  ${EXTRA_FLAGS}
