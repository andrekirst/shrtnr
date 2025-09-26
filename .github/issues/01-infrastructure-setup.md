# Issue #1: Infrastructure Setup & Docker Environment

**Labels:** `enhancement`, `infrastructure`, `mvp`, `priority-high`
**Milestone:** MVP Phase 1
**Estimated Time:** 1 day (8 hours)

## 📋 Description
Set up the complete Docker-based development environment for the shrtnr URL shortener, including all required infrastructure services and development tooling.

## 🎯 Acceptance Criteria
- [ ] Docker Compose configuration for all infrastructure services
- [ ] Redis service with persistence and health checks
- [ ] PostgreSQL service with initialization scripts
- [ ] Kafka + Zookeeper services with proper networking
- [ ] Development environment documentation
- [ ] All services start successfully with `docker-compose up`
- [ ] Health checks pass for all services
- [ ] Management UIs accessible (Kafka UI, Redis Insight)

## 🛠️ Technical Requirements
- **Docker Compose V2** with proper networking
- **Redis 7+** with AOF persistence
- **PostgreSQL 15+** with initialization scripts
- **Kafka 3.0+** with Zookeeper coordination
- **Management UIs** for development debugging

## 📝 Implementation Tasks

### Infrastructure Services
```yaml
# docker-compose.yml structure
services:
  postgres:    # Port 5432
  redis:       # Port 6379
  kafka:       # Port 9092
  zookeeper:   # Port 2181
  kafka-ui:    # Port 8080
  redis-insight: # Port 8081
```

### Configuration Files
- [ ] Environment variables for all services
- [ ] Volume mounts for data persistence
- [ ] Network configuration for service communication
- [ ] Health check definitions

### Documentation
- [ ] README updates with setup instructions
- [ ] Environment variable documentation
- [ ] Port mapping documentation
- [ ] Troubleshooting guide

## 🔧 Implementation Notes
- Use named volumes for data persistence
- Configure proper health checks for all services
- Set up service dependencies in correct order
- Include development-friendly settings (logging, UI access)
- Ensure services can be started individually for debugging

## 📊 Testing Strategy
- [ ] All services start without errors
- [ ] Health checks return healthy status
- [ ] Services can communicate with each other
- [ ] Data persists after container restart
- [ ] Management UIs are accessible and functional

## ✅ Definition of Done
- [ ] Docker Compose file created and tested
- [ ] All infrastructure services running
- [ ] Health checks implemented and passing
- [ ] Documentation updated
- [ ] Setup verified on clean environment
- [ ] CI/CD pipeline can use the infrastructure

## 📁 Affected Files
- `infrastructure/docker-compose.yml`
- `infrastructure/README.md`
- `infrastructure/.env.example`
- `infrastructure/init-scripts/`
- `README.md` (setup instructions)

## 🚀 Success Metrics
- **Startup Time**: < 2 minutes for all services
- **Memory Usage**: < 4GB total for all services
- **Health Check**: 100% services healthy after startup