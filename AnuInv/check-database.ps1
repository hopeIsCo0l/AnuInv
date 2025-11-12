# Check AnuInv Database Status
# Run this script in PowerShell when Docker Desktop is running

Write-Host "`n🔍 Checking AnuInv Database..." -ForegroundColor Cyan
Write-Host ""

# Check if Docker is accessible
Write-Host "1. Checking Docker connection..." -ForegroundColor Yellow
$dockerCheck = docker ps 2>&1
if ($dockerCheck -match "error during connect") {
    Write-Host "   ❌ Docker Desktop engine not accessible" -ForegroundColor Red
    Write-Host "   Please make sure Docker Desktop is fully started" -ForegroundColor Yellow
    exit 1
}
Write-Host "   ✅ Docker is accessible" -ForegroundColor Green

# Check if container is running
Write-Host "`n2. Checking container status..." -ForegroundColor Yellow
$container = docker ps --filter "name=anuinv-postgres" --format "{{.Names}}" 2>&1
if ($container -eq "anuinv-postgres") {
    Write-Host "   ✅ Container is running" -ForegroundColor Green
} else {
    Write-Host "   ❌ Container not running" -ForegroundColor Red
    Write-Host "   Starting container..." -ForegroundColor Yellow
    docker start anuinv-postgres
    Start-Sleep -Seconds 3
}

# List all tables
Write-Host "`n3. Listing all tables..." -ForegroundColor Yellow
docker exec anuinv-postgres psql -U postgres -d anuinv_db -c "\dt" 2>&1

# Count tables
Write-Host "`n4. Counting tables..." -ForegroundColor Yellow
docker exec anuinv-postgres psql -U postgres -d anuinv_db -c "SELECT COUNT(*) as total_tables FROM information_schema.tables WHERE table_schema = 'public';" 2>&1

# Count users
Write-Host "`n5. Counting users..." -ForegroundColor Yellow
docker exec anuinv-postgres psql -U postgres -d anuinv_db -c "SELECT COUNT(*) as user_count FROM users;" 2>&1

# Show users table structure
Write-Host "`n6. Users table structure..." -ForegroundColor Yellow
docker exec anuinv-postgres psql -U postgres -d anuinv_db -c "\d users" 2>&1

# Show sample users
Write-Host "`n7. Sample users (if any)..." -ForegroundColor Yellow
docker exec anuinv-postgres psql -U postgres -d anuinv_db -c "SELECT id, email, \"fullName\", role, \"yNumber\" FROM users LIMIT 5;" 2>&1

# PostgreSQL version
Write-Host "`n8. PostgreSQL version..." -ForegroundColor Yellow
docker exec anuinv-postgres psql -U postgres -d anuinv_db -c "SELECT version();" 2>&1

Write-Host "`n✅ Database check complete!" -ForegroundColor Green
Write-Host "`nTo connect interactively, run:" -ForegroundColor Cyan
Write-Host "  docker exec -it anuinv-postgres psql -U postgres -d anuinv_db" -ForegroundColor Gray
Write-Host ""

