# AnuInv Sys - Database Setup Script
# This script helps you set up the database for AnuInv Sys

Write-Host "=== AnuInv Sys Database Setup ===" -ForegroundColor Cyan
Write-Host ""

# Check if .env file exists
if (-not (Test-Path ".env")) {
    Write-Host "Error: .env file not found!" -ForegroundColor Red
    Write-Host "Please create a .env file in the backend directory first." -ForegroundColor Yellow
    exit 1
}

# Read DATABASE_URL from .env
$envContent = Get-Content ".env"
$dbUrlLine = $envContent | Select-String "DATABASE_URL"

if (-not $dbUrlLine) {
    Write-Host "Error: DATABASE_URL not found in .env file!" -ForegroundColor Red
    exit 1
}

Write-Host "Current DATABASE_URL: $dbUrlLine" -ForegroundColor Yellow
Write-Host ""
Write-Host "Please make sure:" -ForegroundColor Cyan
Write-Host "1. PostgreSQL is installed and running" -ForegroundColor White
Write-Host "2. Database 'anuinv_db' is created" -ForegroundColor White
Write-Host "3. DATABASE_URL in .env has correct credentials" -ForegroundColor White
Write-Host ""

$continue = Read-Host "Have you updated the DATABASE_URL with your PostgreSQL credentials? (y/n)"
if ($continue -ne "y") {
    Write-Host "Please update the DATABASE_URL in .env file and run this script again." -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "Generating Prisma Client..." -ForegroundColor Cyan
npm run prisma:generate

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error generating Prisma Client!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Running database migrations..." -ForegroundColor Cyan
npm run prisma:migrate

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error running migrations!" -ForegroundColor Red
    Write-Host "Please check:" -ForegroundColor Yellow
    Write-Host "1. PostgreSQL is running" -ForegroundColor White
    Write-Host "2. Database exists" -ForegroundColor White
    Write-Host "3. DATABASE_URL is correct" -ForegroundColor White
    exit 1
}

Write-Host ""
Write-Host "✅ Database setup completed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Start the backend server: npm run start:dev" -ForegroundColor White
Write-Host "2. Start the frontend server (in another terminal): cd ../frontend && npm run dev" -ForegroundColor White

