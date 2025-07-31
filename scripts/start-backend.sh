#!/bin/sh
set -a
. ../.env
set +a

podman run -d \
  --name travelgetaway-backend \
  -e DATABASE_URL="postgres://$POSTGRES_USER:$POSTGRES_PASSWORD@localhost:5432/$POSTGRES_DB?sslmode=disable" \
  -p 8080:8080 \
  --network=host \
  travelgetaway-backend