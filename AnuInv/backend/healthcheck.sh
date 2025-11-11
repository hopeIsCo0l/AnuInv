#!/bin/sh
# Health check script for backend
# Returns 0 if healthy, 1 if unhealthy

curl -f http://localhost:${PORT:-3000}/api || exit 1

