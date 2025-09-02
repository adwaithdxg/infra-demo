.PHONY: help start stop restart logs status clean rebuild

# Default target
help:
	@echo "🌟 Fieldiva Core Development Environment"
	@echo "======================================="
	@echo ""
	@echo "Available commands:"
	@echo "  start        Start the development environment"
	@echo "  stop         Stop the development environment"
	@echo "  restart      Restart the development environment"
	@echo "  logs         View logs (usage: make logs SERVICE=service-name)"
	@echo "  status       Check environment status"
	@echo "  rebuild      Rebuild and restart services"
	@echo "  clean        Clean up unused Docker resources"
	@echo ""
	@echo "Examples:"
	@echo "  make start"
	@echo "  make logs SERVICE=admin-service"
	@echo "  make status"
	@echo "  make stop"

start:
	@./scripts/start-dev.sh

stop:
	@./scripts/stop-dev.sh

restart: stop start

logs:
	@if [ -z "$(SERVICE)" ]; then \
		docker-compose logs -f; \
	else \
		docker-compose logs -f $(SERVICE); \
	fi

status:
	@./scripts/status.sh

rebuild:
	@echo "🔨 Rebuilding and restarting services..."
	@docker-compose down
	@docker-compose build --no-cache
	@docker-compose up -d
	@echo "✅ Rebuild completed"

clean:
	@echo "🧹 Cleaning unused Docker resources..."
	@docker system prune -f
	@docker volume prune -f
	@echo "✅ Cleanup completed"

# Service-specific commands
ps:
	@docker-compose ps

shell:
	@if [ -z "$(SERVICE)" ]; then \
		echo "❌ Usage: make shell SERVICE=service-name"; \
		echo "Example: make shell SERVICE=admin-service"; \
		exit 1; \
	fi
	@docker-compose exec $(SERVICE) sh

# Health checks
health:
	@curl -f http://localhost:9000/health && echo "✅ HTTP Gateway healthy"
	@curl -f -k https://localhost:8444/health && echo "✅ HTTPS Gateway healthy"