#!/usr/bin/env bash
set -euo pipefail

if [ ! -f ".env" ]; then
  echo "[start] .env not found. Run ./scripts/setup.sh or create it from .env.example"
  exit 1
fi

docker compose up -d --build
echo "[start] Services starting..."
echo "[start] Try:"
echo "  UI       -> http://ui.localhost:${TRAEFIK_HTTP_PORT:-80}"
echo "  Grafana  -> http://grafana.localhost:${TRAEFIK_HTTP_PORT:-80}"
echo "  Keycloak -> http://auth.localhost:${TRAEFIK_HTTP_PORT:-80}"
