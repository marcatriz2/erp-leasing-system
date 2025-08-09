\# 🚀 ERP Leasing System



\[!\[License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

\[!\[Java](https://img.shields.io/badge/Java-17-orange.svg)](https://openjdk.java.net/projects/jdk/17/)

\[!\[Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2-green.svg)](https://spring.io/projects/spring-boot)

\[!\[Docker](https://img.shields.io/badge/Docker-20.10+-blue.svg)](https://www.docker.com/)



Enterprise-grade microservices-based ERP system for leasing operations with complete infrastructure automation.



\## ✨ Features



\- \*\*🏗️ Microservices Architecture\*\* - 4 independently deployable Spring Boot services

\- \*\*🐳 Docker \& Kubernetes\*\* - Complete containerization and orchestration

\- \*\*🔐 OAuth 2.0 Security\*\* - Keycloak-based authentication and authorization

\- \*\*📊 Monitoring Stack\*\* - Prometheus, Grafana, and alerting

\- \*\*🗄️ Multi-Database\*\* - PostgreSQL per microservice with Redis caching

\- \*\*📚 Complete Documentation\*\* - API docs, architecture guides, deployment instructions



\## 🚀 Quick Start



```bash

\# Clone the repository

git clone https://github.com/TauUsername/erp-leasing-system.git

cd erp-leasing-system



\# Quick start with Docker Compose

chmod +x scripts/\*.sh

./scripts/setup.sh

./scripts/start.sh



\# Access the system

open http://localhost              # Main system

open http://localhost:8080         # Keycloak (admin/admin)

open http://localhost:3000         # Grafana (admin/admin)

