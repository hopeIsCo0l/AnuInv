# Connect to PostgreSQL via Docker
# Make sure Docker Desktop is running first!

Write-Host "`n🔌 Connecting to PostgreSQL database..." -ForegroundColor Cyan

# Check if Docker is running
$dockerRunning = docker ps 2>&1
if ($dockerRunning -match "error during connect" -or $dockerRunning -match "Cannot connect") {
    Write-Host "`n❌ Docker Desktop is not running!" -ForegroundColor Red
    Write-Host "`nPlease:" -ForegroundColor Yellow
    Write-Host "  1. Start Docker Desktop application" -ForegroundColor White
    Write-Host "  2. Wait for it to fully start" -ForegroundColor White
    Write-Host "  3. Run this script again" -ForegroundColor White
    exit 1
}

# Check if container exists and is running
$containerStatus = docker ps -a --filter "name=anuinv-postgres" --format "{{.Status}}" 2>&1
if ($containerStatus -match "Up") {
    Write-Host "✅ Container is running" -ForegroundColor Green
    Write-Host "`nConnecting to database..." -ForegroundColor Cyan
    Write-Host "`nUseful commands:" -ForegroundColor Yellow
    Write-Host "  \dt          - List all tables" -ForegroundColor Gray
    Write-Host "  \d users     - Describe users table" -ForegroundColor Gray
    Write-Host "  SELECT * FROM users;  - Query data" -ForegroundColor Gray
    Write-Host "  \q          - Exit psql" -ForegroundColor Gray
    Write-Host ""
    docker exec -it anuinv-postgres psql -U postgres -d anuinv_db
} elseif ($containerStatus -match "Exited") {
    Write-Host "⚠️  Container exists but is stopped" -ForegroundColor Yellow
    Write-Host "Starting container..." -ForegroundColor Cyan
    docker start anuinv-postgres
    Start-Sleep -Seconds 3
    Write-Host "Connecting..." -ForegroundColor Cyan
    docker exec -it anuinv-postgres psql -U postgres -d anuinv_db
} else {
    Write-Host "❌ Container 'anuinv-postgres' not found!" -ForegroundColor Red
    Write-Host "`nCreate it with:" -ForegroundColor Yellow
    Write-Host "  docker run -d --name anuinv-postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=anuinv_db -p 5433:5432 postgres:15-alpine" -ForegroundColor Gray
}

