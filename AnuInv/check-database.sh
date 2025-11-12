#!/bin/bash
# Check AnuInv Database Status
# Run this script in Git Bash or WSL when Docker Desktop is running

echo ""
echo "🔍 Checking AnuInv Database..."
echo ""

# Check if Docker is accessible
echo "1. Checking Docker connection..."
if ! docker ps > /dev/null 2>&1; then
    echo "   ❌ Docker Desktop engine not accessible"
    echo "   Please make sure Docker Desktop is fully started"
    exit 1
fi
echo "   ✅ Docker is accessible"

# Check if container is running
echo ""
echo "2. Checking container status..."
if docker ps --format "{{.Names}}" | grep -q "anuinv-postgres"; then
    echo "   ✅ Container is running"
else
    echo "   ❌ Container not running"
    echo "   Starting container..."
    docker start anuinv-postgres
    sleep 3
fi

# List all tables
echo ""
echo "3. Listing all tables..."
docker exec anuinv-postgres psql -U postgres -d anuinv_db -c "\dt"

# Count tables
echo ""
echo "4. Counting tables..."
docker exec anuinv-postgres psql -U postgres -d anuinv_db -c "SELECT COUNT(*) as total_tables FROM information_schema.tables WHERE table_schema = 'public';"

# Count users
echo ""
echo "5. Counting users..."
docker exec anuinv-postgres psql -U postgres -d anuinv_db -c "SELECT COUNT(*) as user_count FROM users;"

# Show users table structure
echo ""
echo "6. Users table structure..."
docker exec anuinv-postgres psql -U postgres -d anuinv_db -c "\d users"

# Show sample users
echo ""
echo "7. Sample users (if any)..."
docker exec anuinv-postgres psql -U postgres -d anuinv_db -c "SELECT id, email, \"fullName\", role, \"yNumber\" FROM users LIMIT 5;"

# PostgreSQL version
echo ""
echo "8. PostgreSQL version..."
docker exec anuinv-postgres psql -U postgres -d anuinv_db -c "SELECT version();"

echo ""
echo "✅ Database check complete!"
echo ""
echo "To connect interactively, run:"
echo "  docker exec -it anuinv-postgres psql -U postgres -d anuinv_db"
echo ""

