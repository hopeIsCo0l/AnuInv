#!/bin/sh
# Production build script
# Builds Docker images for production

echo "🏗️  Building AnuInv Sys for production..."

# Build backend
echo "📦 Building backend..."
docker build -t anuinv-backend:latest ./backend

# Build frontend
echo "📦 Building frontend..."
docker build -t anuinv-frontend:latest ./frontend

echo "✅ Build complete!"
echo ""
echo "To start services:"
echo "  docker-compose up"

