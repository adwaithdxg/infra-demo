# Fieldiva Core Development Environment

This directory contains the development environment setup for the Fieldiva core microservices.

## 🏗️ Architecture Overview

### Core Microservices (7 services):
- **Organization Admin Service** (Port 3003 → 8003)
- **Field User Service** (Port 3004 → 8004)
- **Admin Service** (Port 3005 → 8005)
- **Form Service** (Port 3006 → 8006)
- **Media Service** (Port 3007 → 8007)
- **Live Location Service** (Port 3008 → 8008) - with WebSocket support
- **Notification Service** (Port 3009 → 8009)

### Infrastructure Services:
- **MongoDB** (Port 27017) - Database
- **Redis** (Port 6379) - Caching & Sessions
- **RabbitMQ** (Port 5672, Management: 15672) - Message Queue
- **Nginx** (HTTP: 9000, HTTPS: 8444) - API Gateway & Load Balancer

## 🚀 Quick Start

### Prerequisites
- Docker >= 20.x
- Docker Compose >= 2.x
- curl (for health checks)

### Starting the Environment

```bash
# Using the startup script
./scripts/start-dev.sh

# Or using Make
make start

# Or using Docker Compose directly
docker-compose up -d
```

### Stopping the Environment

```bash
# Using the stop script
./scripts/stop-dev.sh

# Or using Make
make stop

# Or using Docker Compose directly
docker-compose down
```

## 📊 Access URLs

### API Gateway
- **HTTP**: http://localhost:9000
- **HTTPS**: https://localhost:8444 (self-signed certificate)

### Management Interfaces
- **RabbitMQ Management**: http://localhost:15672
  - Username: `admin`
  - Password: `securepassword`

### Direct Service Access
| Service | External Port | Internal Port | URL |
|---------|---------------|---------------|-----|
| Organization Admin | 3003 | 8003 | http://localhost:3003 |
| Field User | 3004 | 8004 | http://localhost:3004 |
| Admin | 3005 | 8005 | http://localhost:3005 |
| Form | 3006 | 8006 | http://localhost:3006 |
| Media | 3007 | 8007 | http://localhost:3007 |
| Live Location | 3008 | 8008 | http://localhost:3008 |
| Notification | 3009 | 8009 | http://localhost:3009 |

### API Routes (via Gateway)
| Route | Service | Description |
|-------|---------|-------------|
| `/api/org-admin/` | Organization Admin | Organization management |
| `/api/fielduser/` | Field User | Field user operations |
| `/api/admin/` | Admin | Administrative functions |
| `/api/forms/` | Form | Form management |
| `/api/media/` | Media | File uploads/downloads |
| `/api/location/` | Live Location | Location tracking |
| `/socket.io/` | Live Location | WebSocket connections |
| `/api/notifications/` | Notification | Push notifications |

## 🔧 Management Commands

### Using Make (Recommended)
```bash
make help          # Show available commands
make start         # Start environment
make stop          # Stop environment
make restart       # Restart environment
make status        # Check status
make logs          # View all logs
make logs SERVICE=admin-service  # View specific service logs
make rebuild       # Rebuild and restart
make clean         # Clean unused resources
make health        # Check API gateway health
```

### Using Scripts
```bash
./scripts/start-dev.sh    # Start environment
./scripts/stop-dev.sh     # Stop environment
./scripts/status.sh       # Check status
./scripts/logs.sh [service-name]  # View logs
```

### Using Docker Compose
```bash
docker-compose up -d      # Start services
docker-compose down       # Stop services
docker-compose ps         # Check status
docker-compose logs -f    # View logs
docker-compose restart [service]  # Restart service
```

## 🌐 Networks

The environment uses three external Docker networks:
- **saas-dev-network**: Main network for core services
- **nginx_shared**: Shared network for nginx communication
- **main-network**: Additional network for external integrations

These networks are automatically created when starting the environment.

## 📁 Directory Structure

```
infra/core/development/
├── docker-compose.yml     # Main orchestration file
├── .env                   # Environment variables
├── Makefile              # Management commands
├── README.md             # This file
├── nginx/                # Nginx configuration
│   ├── nginx.conf        # Main nginx config
│   ├── proxy_params      # Proxy parameters
│   ├── ssl_params        # SSL parameters
│   ├── conf.d/           # Additional configs
│   └── ssl/              # SSL certificates
├── configs/              # Service configurations
│   └── redis.conf        # Redis configuration
└── scripts/              # Management scripts
    ├── start-dev.sh      # Start script
    ├── stop-dev.sh       # Stop script
    ├── status.sh         # Status check
    └── logs.sh           # Log viewer
```

## 🔐 Environment Configuration

### Database Credentials
- **MongoDB**: `fieldiva:password123580qwe@mongodb:27017/fieldiva-dev-db`
- **RabbitMQ**: `admin:securepassword`
- **Redis**: No authentication (development only)

### Service Communication
Services communicate internally using Docker service names and internal ports (8003-8009).

### External Access
External clients can access services through:
1. **API Gateway**: http://localhost:9000 or https://localhost:8444
2. **Direct Access**: Individual service ports (3003-3009)

## 🚨 Troubleshooting

### Common Issues

1. **Port conflicts**: Ensure ports 3003-3009, 5672, 6379, 9000, 8444, 15672, 27017 are available
2. **Network issues**: Run `docker network ls` to check if networks exist
3. **Service startup**: Check logs with `make logs SERVICE=service-name`
4. **Health checks**: Use `make status` to see service health

### Debug Commands

```bash
# Check all services
make status

# View specific service logs
make logs SERVICE=admin-service

# Access service shell
make shell SERVICE=admin-service

# Check Docker networks
docker network ls | grep -E "(saas-dev|nginx_shared|main-network)"

# Check volumes
docker volume ls | grep -E "(redis_data|rabbitmq_data|mongo_data)"

# Test API Gateway
curl http://localhost:9000/health
curl -k https://localhost:8444/health
```

### Service Dependencies

Services start in this order:
1. Infrastructure services (MongoDB, Redis, RabbitMQ)
2. Core microservices (all depend on infrastructure)
3. Nginx API Gateway (depends on all microservices)

## 🔄 Development Workflow

1. **Start the environment**: `make start`
2. **Check status**: `make status`
3. **View logs**: `make logs SERVICE=service-name`
4. **Make changes**: Edit your microservice code
5. **Rebuild specific service**: `docker-compose build service-name && docker-compose up -d service-name`
6. **Stop when done**: `make stop`

## 📝 Notes

- This configuration uses development-friendly settings
- Hot reload is enabled through volume mounts
- CORS is configured for local development
- SSL uses self-signed certificates
- Rate limiting is lenient for development
- All services run with debug logging enabled

---

**Important**: This is a development environment. Do not use these configurations in production.