Write-Host "=== ERP Leasing Stack Setup ==="

# Creează .env dacă nu există
if (-Not (Test-Path ".env")) {
    Copy-Item ".env.example" ".env"
    Write-Host "[setup] .env creat din .env.example"
} else {
    Write-Host "[setup] .env există deja"
}

# Creează foldere de date
New-Item -ItemType Directory -Force -Path ".data/grafana" | Out-Null
New-Item -ItemType Directory -Force -Path ".data/keycloak" | Out-Null
Write-Host "[setup] Folderele .data/* au fost create"
