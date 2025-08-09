Write-Host "=== Pornire ERP Leasing Stack ==="

if (-Not (Test-Path ".env")) {
    Write-Host "[start] Lipsă fișier .env. Rulează mai întâi scripts/setup.ps1"
    exit 1
}

# Citește portul Traefik din .env și setează-l în env-ul PowerShell (compose îl va folosi)
$TraefikPort = 80
Get-Content ".env" | ForEach-Object {
    if ($_ -match "^TRAEFIK_HTTP_PORT=(\d+)") { $TraefikPort = [int]$matches[1] }
}
$env:TRAEFIK_HTTP_PORT = "$TraefikPort"

docker compose up -d --build

Write-Host "[start] Serviciile se pornesc..."
Write-Host " UI       -> http://ui.localhost:$TraefikPort"
Write-Host " Grafana  -> http://grafana.localhost:$TraefikPort"
Write-Host " Keycloak -> http://auth.localhost:$TraefikPort"
