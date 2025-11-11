#!/bin/sh
# Cleanup script
# Removes containers, volumes, and images

echo "🧹 Cleaning up AnuInv Docker resources..."

# Stop and remove containers
docker-compose down -v

# Remove images (optional - uncomment if needed)
# docker rmi anuinv-backend anuinv-frontend

echo "✅ Cleanup complete!"

