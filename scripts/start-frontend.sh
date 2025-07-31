#!/bin/sh
podman run -d \
  --name travelgetaway-frontend \
  -p 3000:80 \
  travelgetaway-frontend