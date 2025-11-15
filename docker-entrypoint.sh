#!/bin/sh

CONFIG_FILE="/data/typesense-server.ini"

# Default values if not provided
API_KEY="${TYPESENSE_API_KEY:-local-typesense-key}"
PORT="${TYPESENSE_PORT:-8108}"
CORS_ENABLED="${TYPESENSE_ENABLE_CORS:-true}"
DATA_DIR="${TYPESENSE_DATA_DIR:-/data}"

# Create the data dir if missing (Railway sometimes starts empty)
mkdir -p "$DATA_DIR"

# Write config file
cat <<EOF > "$CONFIG_FILE"
server.port = ${PORT}
server.data_dir = ${DATA_DIR}
server.api_key = ${API_KEY}
server.cors_enabled = ${CORS_ENABLED}
EOF

echo "Starting Typesense with config:"
cat "$CONFIG_FILE"

# Start Typesense
exec /opt/typesense-server \
  --config "$CONFIG_FILE" \
  --data-dir "$DATA_DIR" \
  --api-key "$API_KEY" \
  --enable-cors="$CORS_ENABLED" \
  --port "$PORT"
