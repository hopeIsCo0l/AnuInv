# Railway CLI Setup Script for Windows PowerShell
# Run this script step by step in PowerShell

Write-Host "🚀 Railway CLI Setup for AnuInv Sys" -ForegroundColor Cyan
Write-Host ""

# Step 1: Login
Write-Host "Step 1: Login to Railway" -ForegroundColor Yellow
Write-Host "This will open a browser for authentication..."
railway login

# Step 2: Setup Backend
Write-Host ""
Write-Host "Step 2: Setting up Backend Service" -ForegroundColor Yellow
Set-Location backend

Write-Host "Linking backend service..."
railway link

Write-Host "Setting backend environment variables..."
Write-Host "Note: You'll need to set DATABASE_URL manually after creating PostgreSQL database"
railway variables set SMTP_HOST=smtp.gmail.com
railway variables set SMTP_PORT=587
railway variables set SMTP_FROM=noreply@anuinv.com
railway variables set PORT=3000
railway variables set NODE_ENV=production

# Generate JWT Secret
$jwtSecret = node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
railway variables set JWT_SECRET=$jwtSecret
Write-Host "✅ JWT_SECRET generated and set" -ForegroundColor Green

Write-Host ""
Write-Host "⚠️  IMPORTANT: Set these variables manually:" -ForegroundColor Yellow
Write-Host "  - DATABASE_URL (from PostgreSQL service)" -ForegroundColor Yellow
Write-Host "  - SMTP_USER (your email)" -ForegroundColor Yellow
Write-Host "  - SMTP_PASS (your Gmail app password)" -ForegroundColor Yellow
Write-Host "  - FRONTEND_URL (after frontend deploys)" -ForegroundColor Yellow

# Step 3: Setup Frontend
Write-Host ""
Write-Host "Step 3: Setting up Frontend Service" -ForegroundColor Yellow
Set-Location ../frontend

Write-Host "Linking frontend service..."
railway link

Write-Host "Setting frontend environment variables..."
railway variables set PORT=3001
railway variables set NODE_ENV=production

Write-Host ""
Write-Host "⚠️  IMPORTANT: Set this variable manually:" -ForegroundColor Yellow
Write-Host "  - NEXT_PUBLIC_API_URL (backend Railway URL)" -ForegroundColor Yellow

# Step 4: Summary
Write-Host ""
Write-Host "✅ Setup Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Cyan
Write-Host "1. Create PostgreSQL database in Railway UI" -ForegroundColor White
Write-Host "2. Set DATABASE_URL in backend service variables" -ForegroundColor White
Write-Host "3. Set SMTP credentials in backend service variables" -ForegroundColor White
Write-Host "4. Deploy backend: cd backend && railway up" -ForegroundColor White
Write-Host "5. Deploy frontend: cd frontend && railway up" -ForegroundColor White
Write-Host "6. Set FRONTEND_URL and NEXT_PUBLIC_API_URL after deployment" -ForegroundColor White

Set-Location ..

