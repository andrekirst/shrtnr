# Infrastructure Setup

Docker Compose configuration for shrtnr services.

## Services

### Core Data Services
- **PostgreSQL** (Port 5432): Primary database with ACID transactions
- **Redis** (Port 6379): High-speed cache for URL lookups
- **Kafka** (Port 9092): Event streaming platform
- **Zookeeper** (Port 2181): Kafka coordination service

### Management UIs (Optional)
- **Kafka UI** (Port 8080): Web interface for Kafka management
- **Redis Insight** (Port 8081): Redis database browser

## Quick Start

```bash
# Start all infrastructure services
cd infrastructure
docker-compose up -d

# Check service status
docker-compose ps

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Reset data (careful!)
docker-compose down -v
```

## Service Configuration

### PostgreSQL
- **Database**: `shrtnr`
- **User**: `shrtnr_user`
- **Password**: `shrtnr_password`
- **Initialization**: Automatic schema setup via init scripts

### Redis
- **Persistence**: AOF enabled
- **Configuration**: Default Redis settings
- **Data Model**: Key-value pairs (short_code → full_url)

### Kafka
- **Topics**: Auto-created
- **Replication**: Single node setup (increase for production)
- **Retention**: Default settings

## Environment Variables

Create `.env` file for customization:

```env
# PostgreSQL
POSTGRES_DB=shrtnr
POSTGRES_USER=shrtnr_user
POSTGRES_PASSWORD=shrtnr_password

# Redis
REDIS_PASSWORD=optional_password

# Kafka
KAFKA_BROKER_ID=1
```

## Production Notes

For production deployment:
1. Use external volumes for data persistence
2. Enable authentication and SSL/TLS
3. Configure proper resource limits
4. Set up monitoring and health checks
5. Use multiple Kafka brokers for redundancy