# Restart Frontend Dev Server
# This script clears Next.js cache and restarts the dev server

Write-Host "`n🔄 Restarting Frontend Dev Server..." -ForegroundColor Cyan

# Navigate to frontend directory
Set-Location frontend

# Clear Next.js cache
if (Test-Path .next) {
    Write-Host "`n🗑️  Removing .next cache folder..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force .next
    Write-Host "✅ Cache cleared!" -ForegroundColor Green
} else {
    Write-Host "`n✅ No cache to clear" -ForegroundColor Green
}

Write-Host "`n🚀 Starting dev server..." -ForegroundColor Cyan
Write-Host "`nThe server will start on http://localhost:3001" -ForegroundColor Yellow
Write-Host "Press Ctrl+C to stop the server`n" -ForegroundColor Gray

# Start dev server
npm run dev

