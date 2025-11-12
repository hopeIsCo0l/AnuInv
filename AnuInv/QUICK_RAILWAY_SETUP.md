# Quick Railway CLI Setup - Run These Commands

## ⚠️ IMPORTANT: Login First

You need to authenticate with Railway first. Run this command:

```powershell
railway login
```

This will open your browser. After logging in, come back here and continue.

---

## After Login - Run This Script

Once logged in, run the automated setup:

```powershell
.\setup-railway-auto.ps1
```

Or run commands manually:

### 1. Setup Backend
```powershell
cd backend
railway link
railway variables set SMTP_HOST=smtp.gmail.com
railway variables set SMTP_PORT=587
railway variables set SMTP_FROM=noreply@anuinv.com
railway variables set PORT=3000
railway variables set NODE_ENV=production

# Generate JWT secret
$secret = node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
railway variables set JWT_SECRET=$secret
```

### 2. Setup Frontend
```powershell
cd ../frontend
railway link
railway variables set PORT=3001
railway variables set NODE_ENV=production
```

### 3. Create PostgreSQL Database
Go to Railway UI → New Service → Database → PostgreSQL

Then set DATABASE_URL:
```powershell
cd ../backend
railway variables set DATABASE_URL=<from-postgres-service>
```

### 4. Deploy
```powershell
# Backend
cd backend
railway up

# Frontend (in another terminal)
cd frontend
railway up
```

---

## What the Script Does

✅ Checks if you're logged in  
✅ Links backend service (sets root directory automatically)  
✅ Sets backend environment variables  
✅ Generates JWT secret  
✅ Links frontend service (sets root directory automatically)  
✅ Sets frontend environment variables  

## Manual Steps After Script

1. Create PostgreSQL database in Railway UI
2. Set `DATABASE_URL` in backend
3. Set `SMTP_USER` and `SMTP_PASS` in backend
4. Deploy both services
5. Set `FRONTEND_URL` and `NEXT_PUBLIC_API_URL` after deployment

