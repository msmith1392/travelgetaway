#!/bin/sh
set -a
. ../.env
set +a

# Start DB if not running
if ! podman ps --format "{{.Names}}" | grep -q "^travelgetaway-db$"; then
  echo "Starting Postgres container..."
  podman run -d \
    --name travelgetaway-db \
    -e POSTGRES_DB=$POSTGRES_DB \
    -e POSTGRES_USER=$POSTGRES_USER \
    -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
    -p 5432:5432 \
    -v travelgetaway_pgdata:/var/lib/postgresql/data \
    postgres:16-alpine
else
  echo "Postgres container already running."
fi

echo "Waiting for Postgres to be ready..."
until podman exec travelgetaway-db pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"; do
  sleep 2
done

echo "Postgres is ready. Starting backend..."

podman run -d \
  --name travelgetaway-backend \
  -e DATABASE_URL="postgres://$POSTGRES_USER:$POSTGRES_PASSWORD@localhost:5432/$POSTGRES_DB?sslmode=disable" \
  -p 8080:8080 \
  --network=host \
  travelgetaway-backend