#!/bin/sh
set -e

echo "🚀 Starting AnuInv Frontend..."

# Check if Next.js is available
if ! command -v next > /dev/null 2>&1; then
  echo "❌ Next.js not found. Checking node_modules..."
  if [ -d "node_modules/.bin" ]; then
    export PATH="$PATH:$(pwd)/node_modules/.bin"
    echo "✅ Added node_modules/.bin to PATH"
  else
    echo "❌ node_modules/.bin not found. Installing dependencies..."
    npm ci
  fi
fi

# Start Next.js server
echo "🎯 Starting Next.js application..."
PORT=${PORT:-3001}
exec next start -p "$PORT"

