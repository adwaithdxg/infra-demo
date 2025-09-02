#!/bin/bash
set -e

case "$1" in
  infra)
    echo "🚀 Starting infra services..."
    docker compose -f docker-compose.infra.yml up -d
    ;;
  micro)
    echo "🚀 Starting microservices..."
    docker compose -f docker-compose.microservices.yml up -d
    ;;
  all)
    echo "🚀 Starting infra + microservices..."
    docker compose -f docker-compose.infra.yml -f docker-compose.microservices.yml up -d
    ;;
  down)
    echo "🛑 Stopping all services..."
    docker compose -f docker-compose.infra.yml -f docker-compose.microservices.yml down
    ;;
  *)
    echo "Usage: $0 {infra|micro|all|down}"
    exit 1
    ;;
esac
