#!/usr/bin/env bash
set -euo pipefail

if [ ! -f ".env" ]; then
  cp .env.example .env
  echo "[setup] Generated .env from .env.example"
else
  echo "[setup] .env already exists"
fi

mkdir -p ./.data/grafana ./.data/keycloak
echo "[setup] Created data folders (.data/*)"
