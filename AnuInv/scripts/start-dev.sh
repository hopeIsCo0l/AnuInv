#!/bin/sh
# Development startup script
# Starts all services in development mode

echo "🚀 Starting AnuInv Sys in development mode..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
  echo "❌ Docker is not running. Please start Docker Desktop."
  exit 1
fi

# Start services
docker-compose up --build

