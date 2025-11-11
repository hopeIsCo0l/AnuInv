#!/bin/sh
# Database initialization script (optional)
# This can be used to seed initial data or run setup commands

echo "📦 Initializing database..."

# Wait for PostgreSQL to be ready
until pg_isready -h postgres -U postgres; do
  echo "Waiting for PostgreSQL..."
  sleep 1
done

echo "✅ PostgreSQL is ready!"

# Run any initialization SQL scripts here
# Example:
# psql -h postgres -U postgres -d anuinv_db -f /docker-entrypoint-initdb.d/init.sql

echo "✅ Database initialization complete!"

