.PHONY: help build up down \
        logs status clean dev-setup

COMPOSE_FILE := docker/docker-compose.yaml
DB_CONTAINER := temporal-postgresql
DB_USER := temporal
DB_PASSWORD := temporal
DB_NAME := app_db
ALEMBIC_CONFIG := database/alembic.ini

# ========================================

help:
	@echo "========================================================="
	@echo "Available Make Commands"
	@echo "========================================================="
	@echo "build          - Build Docker containers"
	@echo "up             - Start all services with Docker Compose"
	@echo "down           - Stop all services"
	@echo ""
	@echo "Development Commands:"
	@echo "dev-setup      - Complete development environment setup"
	@echo "logs           - View Docker Compose logs"
	@echo "status         - Show status of all services"
	@echo "clean          - Clean up Docker containers and volumes"
	@echo ""
	@echo "========================================================="

# ========================================
# Docker Commands
# ========================================

build:
	@echo "Building Docker containers..."
	docker-compose -f $(COMPOSE_FILE) build

up:
	@echo "Starting all services..."
	docker-compose -f $(COMPOSE_FILE) up -d
	@echo "Services started. Access Temporal UI at http://localhost:8080"

down:
	@echo "Stopping all services..."
	docker-compose -f $(COMPOSE_FILE) down
	@echo "All services stopped."

# ========================================
# Development Commands
# ========================================

dev-setup:
	$(MAKE) up
	

logs:
	@echo "Viewing Docker Compose logs (Ctrl+C to exit)..."
	docker-compose -f $(COMPOSE_FILE) logs -f

status:
	@echo "Service Status:"
	@echo "=============="
	docker-compose -f $(COMPOSE_FILE) ps
	@echo ""
	@echo "Container Health:"
	@echo "================"
	docker ps --filter "name=temporal" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

clean:
	@echo "Cleaning up Docker containers and volumes..."
	docker-compose -f $(COMPOSE_FILE) down -v --remove-orphans
	docker system prune -f
	@echo "Cleanup completed."