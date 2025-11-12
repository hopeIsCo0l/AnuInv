# Railway CLI - Complete Automated Setup

## What I've Prepared:

✅ Railway CLI is installed (v4.10.0)  
✅ Configuration files ready (`railway.json`, `nixpacks.toml`)  
✅ Automated setup script created (`setup-railway-auto.ps1`)  
✅ All code pushed to GitHub  

## What You Need to Do:

### Step 1: Login (Browser Required)
Run this command - it will open your browser:
```powershell
railway login
```

### Step 2: Run Automated Setup
After login, run:
```powershell
.\setup-railway-auto.ps1
```

This script will:
- ✅ Link backend service (auto-sets root directory to `backend/`)
- ✅ Set backend environment variables
- ✅ Generate JWT secret
- ✅ Link frontend service (auto-sets root directory to `frontend/`)
- ✅ Set frontend environment variables

### Step 3: Manual Steps After Script

1. **Create PostgreSQL Database**:
   - Go to Railway UI → New Service → Database → PostgreSQL
   - Copy the `DATABASE_URL`

2. **Set Remaining Variables**:
   ```powershell
   cd backend
   railway variables set DATABASE_URL=<paste-url-here>
   railway variables set SMTP_USER=<your-email@gmail.com>
   railway variables set SMTP_PASS=<gmail-app-password>
   ```

3. **Deploy**:
   ```powershell
   # Backend
   cd backend
   railway up
   
   # Frontend (after backend URL is available)
   cd frontend
   railway variables set NEXT_PUBLIC_API_URL=<backend-url>
   railway up
   ```

## Why Root Directory is Auto-Set

When you run `railway link` from the `backend/` or `frontend/` directory, Railway automatically detects that as the root directory. This solves the "could not determine how to build" error!

## Files Created:

- `setup-railway-auto.ps1` - Automated setup script
- `QUICK_RAILWAY_SETUP.md` - Quick reference guide
- `RAILWAY_CLI_COMMANDS.md` - All CLI commands
- `RAILWAY_CLI_SETUP.md` - Detailed setup guide

---

**Start with: `railway login` then run `.\setup-railway-auto.ps1`**

