#!/bin/sh
set -e

echo "🚀 Starting AnuInv Backend..."

# Wait for database to be ready
echo "⏳ Waiting for database to be ready..."
# Extract host from DATABASE_URL or use default
DB_HOST=$(echo $DATABASE_URL | sed -n 's/.*@\([^:]*\):.*/\1/p' || echo "postgres")

# Simple connection test - try connecting to PostgreSQL
until pg_isready -h "$DB_HOST" -U postgres > /dev/null 2>&1 || nc -z "$DB_HOST" 5432 > /dev/null 2>&1 || timeout 1 bash -c "cat < /dev/null > /dev/tcp/$DB_HOST/5432" 2>/dev/null; do
  echo "Database is unavailable - sleeping"
  sleep 1
done

echo "✅ Database is ready!"

# Run migrations or push schema
echo "📦 Setting up database schema..."
# Use db push for simplicity (works better in Docker)
echo "Pushing schema to database..."
npx prisma db push --accept-data-loss --skip-generate
echo "✅ Database schema ready!"

# Start the application
echo "🎯 Starting NestJS application..."
exec npm run start:prod
