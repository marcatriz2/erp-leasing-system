#!/usr/bin/env bash
set -euo pipefail

docker compose down -v
echo "[stop] All containers removed (including volumes)"
