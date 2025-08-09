#!/bin/bash

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_step() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }

echo "🚀 ERP Leasing System - Initial Setup"
echo "======================================"

print_step "Creating configuration files..."

# Create .env if not exists
if [ ! -f .env ]; then
    cat > .env << 'ENV_EOF'
POSTGRES_PASSWORD=SecurePassword123!
REDIS_PASSWORD=RedisSecurePass123!
KEYCLOAK_ADMIN_USER=admin
KEYCLOAK_ADMIN_PASSWORD=admin
GRAFANA_ADMIN_PASSWORD=admin
ENVIRONMENT=development
ENV_EOF
    print_success "Environment file created (.env)"
fi

# Create database init scripts
for db in product-config offer-management customer-management risk-assessment; do
    cat > infrastructure/databases/${db}/init/01_create_extensions.sql << SQL_EOF
-- Create necessary extensions for ${db} DB
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- Create schema
CREATE SCHEMA IF NOT EXISTS ${db//-/_};
SQL_EOF
done

# Create Prometheus config
cat > infrastructure/monitoring/prometheus/prometheus.yml << 'PROM_EOF'
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
PROM_EOF

# Create Grafana datasource
cat > infrastructure/monitoring/grafana/datasources/prometheus.yml << 'GRAFANA_EOF'
apiVersion: 1
datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://prometheus:9090
    isDefault: true
GRAFANA_EOF

# Create Nginx config
cat > infrastructure/nginx/nginx.conf << 'NGINX_EOF'
events {
    worker_connections 1024;
}

http {
    server {
        listen 80;
        server_name localhost;

        location /health {
            access_log off;
            return 200 "ERP Leasing System - Healthy\n";
            add_header Content-Type text/plain;
        }

        location / {
            return 200 "🚀 ERP Leasing System - Ready!\n\nAccess:\n- Keycloak: http://localhost:8080\n- Grafana: http://localhost:3000\n";
            add_header Content-Type text/plain;
        }
    }
}
NGINX_EOF

# Create Keycloak realm
cat > infrastructure/security/keycloak/erp-realm.json << 'KEYCLOAK_EOF'
{
  "realm": "erp-leasing",
  "enabled": true,
  "displayName": "ERP Leasing System",
  "users": [
    {
      "username": "admin",
      "enabled": true,
      "credentials": [
        {
          "type": "password",
          "value": "admin",
          "temporary": false
        }
      ]
    }
  ]
}
KEYCLOAK_EOF

print_success "✅ Setup completed successfully!"
echo ""
echo "🚀 Next step: ./scripts/start.sh"