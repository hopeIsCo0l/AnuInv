# Railway CLI Automated Setup
# This script will configure your Railway services via CLI

Write-Host "🚀 Railway CLI Setup for AnuInv Sys" -ForegroundColor Cyan
Write-Host ""

# Check if logged in
Write-Host "Checking Railway authentication..." -ForegroundColor Yellow
$authCheck = railway whoami 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Not logged in. Please run: railway login" -ForegroundColor Red
    Write-Host "This will open a browser for authentication." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "After logging in, run this script again or continue manually." -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Authenticated as: $authCheck" -ForegroundColor Green
Write-Host ""

# Step 1: Setup Backend
Write-Host "Step 1: Setting up Backend Service" -ForegroundColor Yellow
Set-Location backend

Write-Host "Linking backend service to Railway..." -ForegroundColor Cyan
railway link

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to link backend service" -ForegroundColor Red
    Write-Host "Please run 'railway link' manually and select your project" -ForegroundColor Yellow
    Set-Location ..
    exit 1
}

Write-Host "✅ Backend service linked" -ForegroundColor Green

Write-Host "Setting backend environment variables..." -ForegroundColor Cyan
railway variables set SMTP_HOST=smtp.gmail.com
railway variables set SMTP_PORT=587
railway variables set SMTP_FROM=noreply@anuinv.com
railway variables set PORT=3000
railway variables set NODE_ENV=production

# Generate JWT Secret
Write-Host "Generating JWT secret..." -ForegroundColor Cyan
$jwtSecret = node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
if ($LASTEXITCODE -eq 0) {
    railway variables set JWT_SECRET=$jwtSecret
    Write-Host "✅ JWT_SECRET generated and set" -ForegroundColor Green
} else {
    Write-Host "⚠️  Could not generate JWT secret. Set it manually:" -ForegroundColor Yellow
    Write-Host "   railway variables set JWT_SECRET=<random-secret>" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "⚠️  MANUAL STEP REQUIRED:" -ForegroundColor Yellow
Write-Host "   Set these variables after creating PostgreSQL database:" -ForegroundColor Yellow
Write-Host "   railway variables set DATABASE_URL=<from-postgres-service>" -ForegroundColor Yellow
Write-Host "   railway variables set SMTP_USER=<your-email@gmail.com>" -ForegroundColor Yellow
Write-Host "   railway variables set SMTP_PASS=<gmail-app-password>" -ForegroundColor Yellow
Write-Host "   railway variables set FRONTEND_URL=<frontend-url-after-deploy>" -ForegroundColor Yellow

# Step 2: Setup Frontend
Write-Host ""
Write-Host "Step 2: Setting up Frontend Service" -ForegroundColor Yellow
Set-Location ../frontend

Write-Host "Linking frontend service to Railway..." -ForegroundColor Cyan
railway link

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to link frontend service" -ForegroundColor Red
    Write-Host "Please run 'railway link' manually and select your project" -ForegroundColor Yellow
    Set-Location ..
    exit 1
}

Write-Host "✅ Frontend service linked" -ForegroundColor Green

Write-Host "Setting frontend environment variables..." -ForegroundColor Cyan
railway variables set PORT=3001
railway variables set NODE_ENV=production

Write-Host ""
Write-Host "⚠️  MANUAL STEP REQUIRED:" -ForegroundColor Yellow
Write-Host "   Set this variable after backend deploys:" -ForegroundColor Yellow
Write-Host "   railway variables set NEXT_PUBLIC_API_URL=<backend-railway-url>" -ForegroundColor Yellow

# Summary
Write-Host ""
Write-Host "✅ Setup Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "1. Create PostgreSQL database in Railway UI" -ForegroundColor White
Write-Host "2. Set remaining backend variables (see above)" -ForegroundColor White
Write-Host "3. Deploy backend: cd backend && railway up" -ForegroundColor White
Write-Host "4. Deploy frontend: cd frontend && railway up" -ForegroundColor White
Write-Host "5. Set NEXT_PUBLIC_API_URL and FRONTEND_URL after deployment" -ForegroundColor White

Set-Location ..

