# ERP Leasing System — Bootstrap & Dev Setup (PR 1)

This PR makes the repo runnable out of the box and fixes several issues:

- Correct clone URL
- Proper `.gitignore` and `LICENSE`
- `.env.example` with configurable host ports
- `docker-compose.yml` with **Traefik** reverse proxy
- Minimal **UI landing** so `http://ui.localhost` works immediately
- Healthchecks + scripts (`setup.sh`, `start.sh`, `stop.sh`, `build.sh`)

## Quick Start (local)

```bash
# 1) Create your .env from template
cp .env.example .env

# 2) Start everything
chmod +x scripts/*.sh
./scripts/start.sh

# 3) Open the apps (use Chrome/Edge)
# UI landing:
http://ui.localhost
# Grafana:
http://grafana.localhost
# Keycloak (dev only):
http://auth.localhost
```

> If port 80 is busy, change `TRAEFIK_HTTP_PORT` in `.env` (e.g. 8085) and then use `http://ui.localhost:8085` etc.

## Endpoints (via Traefik)

- **UI**: `http://ui.localhost` → `ui` container (static landing for now)
- **Grafana**: `http://grafana.localhost` → `grafana:3000`
- **Keycloak**: `http://auth.localhost` → `keycloak:8080`

You can add your API gateway and microservices later by adding labels like these to each service:

```yaml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.api.rule=Host(`api.localhost`)"
  - "traefik.http.services.api.loadbalancer.server.port=8080"  # internal container port
```

## Development workflow

- Update ports and credentials in `.env`
- Put your Spring Boot services under `services/<name>` and add them to `docker-compose.yml`
- For each service, add Traefik labels as above

## Git basics (GitHub Desktop friendly)

1. Create a branch (e.g. `chore/bootstrap-stack`).
2. Add/commit files from this PR bundle.
3. Push and open a Pull Request.
4. Review and merge into `main`.

## License

MIT (see `LICENSE`).
