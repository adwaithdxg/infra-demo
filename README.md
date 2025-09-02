# Fieldiva Infrastructure

Scalable infrastructure setup for the Fieldiva platform, organized by business domains and environments.

## 🏗️ Structure Overview

```
infra/
├── core/                 # Core microservices infrastructure
│   ├── development/      # Development environment for core services
│   └── production/       # Production environment for core services (TODO)
├── business/             # Business logic services infrastructure
│   ├── development/      # Development environment for business services (TODO)
│   └── production/       # Production environment for business services (TODO)
└── README.md            # This file
```

## 🎯 Current Status

### ✅ Completed
- **Core Development Environment**: Fully configured and ready to use

### 🚧 Planned
- **Core Production Environment**: Production-ready configurations
- **Business Development Environment**: Business logic services
- **Business Production Environment**: Production business services

## 🚀 Quick Start

### Core Development Environment

```bash
cd infra/core/development
make start
```

**Access URLs:**
- API Gateway: http://localhost:9000
- HTTPS Gateway: https://localhost:8444
- RabbitMQ Management: http://localhost:15672

## 📊 Service Architecture

### Core Services (Development)
| Service | External Port | Internal Port | Status |
|---------|---------------|---------------|---------|
| Organization Admin | 3003 | 8003 | ✅ Ready |
| Field User | 3004 | 8004 | ✅ Ready |
| Admin | 3005 | 8005 | ✅ Ready |
| Form | 3006 | 8006 | ✅ Ready |
| Media | 3007 | 8007 | ✅ Ready |
| Live Location | 3008 | 8008 | ✅ Ready |
| Notification | 3009 | 8009 | ✅ Ready |

### Infrastructure Services
| Service | Port | Purpose | Status |
|---------|------|---------|---------|
| MongoDB | 27017 | Database | ✅ Ready |
| Redis | 6379 | Cache/Sessions | ✅ Ready |
| RabbitMQ | 5672/15672 | Message Queue | ✅ Ready |
| Nginx | 9000/8444 | API Gateway | ✅ Ready |

## 🔧 Management

### Core Development
```bash
cd infra/core/development
make help          # Show available commands
make start         # Start environment
make status        # Check status
make logs SERVICE=admin-service  # View logs
make stop          # Stop environment
```

### Global Commands
```bash
# Navigate to specific environment
cd infra/core/development     # Core development
cd infra/core/production      # Core production (TODO)
cd infra/business/development # Business development (TODO)
cd infra/business/production  # Business production (TODO)
```

## 🌐 Network Architecture

The infrastructure uses external Docker networks for service isolation and communication:

- **saas-dev-network**: Core development services
- **nginx_shared**: Nginx gateway communication
- **main-network**: Cross-domain service communication

## 📝 Configuration Management

Each environment maintains its own:
- Docker Compose configuration
- Environment variables (.env)
- Nginx routing configuration
- Service-specific configs
- SSL certificates
- Deployment scripts

## 🔒 Security Notes

### Development
- Uses development credentials
- Self-signed SSL certificates
- Relaxed CORS policies
- Debug logging enabled

### Production (When Implemented)
- Encrypted secrets management
- Production SSL certificates
- Strict security headers
- Rate limiting and DDoS protection

## 📚 Documentation

For detailed information about each environment:
- [Core Development Environment](./core/development/README.md)
- Core Production Environment (TODO)
- Business Development Environment (TODO) 
- Business Production Environment (TODO)

---

**Note**: This infrastructure is designed to be scalable and maintainable. Each environment is self-contained and can be deployed independently.