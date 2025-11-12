# Railway CLI Quick Commands

## Initial Setup (Run Once)

### 1. Login to Railway
```powershell
railway login
```

### 2. Setup Backend Service
```powershell
cd backend
railway link
railway variables set SMTP_HOST=smtp.gmail.com
railway variables set SMTP_PORT=587
railway variables set SMTP_FROM=noreply@anuinv.com
railway variables set PORT=3000
railway variables set NODE_ENV=production

# Generate and set JWT secret
$secret = node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
railway variables set JWT_SECRET=$secret
```

### 3. Setup Frontend Service
```powershell
cd ../frontend
railway link
railway variables set PORT=3001
railway variables set NODE_ENV=production
```

## Manual Variables to Set (After Creating PostgreSQL)

### Backend Variables:
```powershell
cd backend
railway variables set DATABASE_URL=<from-postgres-service>
railway variables set SMTP_USER=<your-email@gmail.com>
railway variables set SMTP_PASS=<gmail-app-password>
railway variables set FRONTEND_URL=<frontend-railway-url>
```

### Frontend Variables:
```powershell
cd frontend
railway variables set NEXT_PUBLIC_API_URL=<backend-railway-url>
```

## Deploy Commands

### Deploy Backend:
```powershell
cd backend
railway up
```

### Deploy Frontend:
```powershell
cd frontend
railway up
```

## Useful Commands

```powershell
# Check service status
railway status

# View logs
railway logs

# View variables
railway variables

# Open in browser
railway open

# List services
railway service list
```

## Important Notes

1. **Root Directory**: When you run `railway link` from `backend/` or `frontend/`, Railway automatically sets the root directory to that folder.

2. **PostgreSQL Database**: Create it in Railway UI first, then use the `DATABASE_URL` variable.

3. **Service Names**: Railway will prompt you to name services - use "backend" and "frontend".

4. **Deployment**: After linking, Railway will auto-deploy on git push, or use `railway up` for manual deployment.

