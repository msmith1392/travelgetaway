#!/bin/sh
set -a
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/.."
. "$PROJECT_ROOT/.env"
set +a

podman run -d \
  --name travelgetaway-db \
  -e POSTGRES_DB=$POSTGRES_DB \
  -e POSTGRES_USER=$POSTGRES_USER \
  -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
  -p 5432:5432 \
  -v travelgetaway_pgdata:/var/lib/postgresql/data \
  postgres:16-alpine