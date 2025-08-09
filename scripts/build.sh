#!/usr/bin/env bash
set -euo pipefail
docker compose build
echo "[build] Images built"
