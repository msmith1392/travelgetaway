#!/bin/sh
set -a
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/.."
. "$PROJECT_ROOT/.env"
set +a

podman run -d \
  --name travelgetaway-backend \
  -e DATABASE_URL="postgres://$POSTGRES_USER:$POSTGRES_PASSWORD@localhost:5432/$POSTGRES_DB?sslmode=disable" \
  -p 8080:8080 \
  --network=host \
  travelgetaway-backend