# Start Local Development - PowerShell Script

Write-Host "🚀 Starting AnuInv Sys Locally..." -ForegroundColor Cyan
Write-Host ""

# Check if Docker is available
$dockerAvailable = Get-Command docker -ErrorAction SilentlyContinue

if ($dockerAvailable) {
    Write-Host "✅ Docker found - Using Docker Compose" -ForegroundColor Green
    Write-Host ""
    Write-Host "Starting services..." -ForegroundColor Yellow
    docker-compose up
} else {
    Write-Host "⚠️  Docker not found - Using manual setup" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please follow these steps:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Start PostgreSQL database" -ForegroundColor White
    Write-Host "2. Setup backend (see LOCAL_TESTING.md)" -ForegroundColor White
    Write-Host "3. Setup frontend (see LOCAL_TESTING.md)" -ForegroundColor White
    Write-Host ""
    Write-Host "Or install Docker Desktop: https://www.docker.com/products/docker-desktop" -ForegroundColor Gray
}

