#!/bin/sh
set -a
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/.."
. "$PROJECT_ROOT/.env"
set +a

echo "Checking for existing Postgres container..."

if podman ps --format "{{.Names}}" | grep -q "^travelgetaway-db$"; then
  echo "Postgres container already running."
elif podman ps -a --format "{{.Names}}" | grep -q "^travelgetaway-db$"; then
  echo "Starting existing (stopped) Postgres container..."
  podman start travelgetaway-db
else
  echo "Creating and starting new Postgres container..."
  podman run -d \
    --name travelgetaway-db \
    -e POSTGRES_DB=$POSTGRES_DB \
    -e POSTGRES_USER=$POSTGRES_USER \
    -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
    -p 5432:5432 \
    -v travelgetaway_pgdata:/var/lib/postgresql/data \
    postgres:16-alpine
fi

echo "Waiting for Postgres to be ready..."
until podman exec travelgetaway-db pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"; do
  sleep 2
done

echo "Postgres is ready."