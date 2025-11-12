# Railway Deployment Fix - Root Directory Configuration

## Problem
Railway was detecting `AnuInv/` as a subdirectory and couldn't determine how to build the app.

## Solution
Railway needs to know the **Root Directory** for each service. You must configure this in Railway's UI.

## Step-by-Step Fix

### 1. Create Backend Service
1. Go to your Railway project dashboard
2. Click **"New Service"** → **"GitHub Repo"**
3. Select your repository: `hopeIsCo0l/AnuInv`
4. **IMPORTANT**: In the service settings, set **Root Directory** to: `backend`
5. Railway will now detect:
   - `backend/package.json` (Node.js project)
   - `backend/nixpacks.toml` (build configuration)
   - `backend/railway.json` (deploy configuration)

### 2. Create Frontend Service
1. Click **"New Service"** → **"GitHub Repo"**
2. Select the same repository: `hopeIsCo0l/AnuInv`
3. **IMPORTANT**: Set **Root Directory** to: `frontend`
4. Railway will detect:
   - `frontend/package.json` (Node.js project)
   - `frontend/nixpacks.toml` (build configuration)
   - `frontend/railway.json` (deploy configuration)

### 3. Add PostgreSQL Database
1. Click **"New Service"** → **"Database"** → **"PostgreSQL"**
2. Railway will create the database automatically
3. Connect it to your backend service:
   - Go to backend service → **Variables**
   - Add `DATABASE_URL` from the PostgreSQL service

### 4. Configure Environment Variables

#### Backend Service Variables:
```
DATABASE_URL=<from PostgreSQL service>
JWT_SECRET=<generate a random secret>
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=<your-email@gmail.com>
SMTP_PASS=<your-app-password>
SMTP_FROM=noreply@anuinv.com
FRONTEND_URL=<your-frontend-railway-url>
PORT=3000
NODE_ENV=production
```

#### Frontend Service Variables:
```
NEXT_PUBLIC_API_URL=<your-backend-railway-url>
PORT=3001
NODE_ENV=production
```

## Why Root Directory is Critical

Without setting the root directory, Railway looks at the repository root and sees:
```
./
└── AnuInv/  ← Railway thinks this is a subdirectory
```

With root directory set to `backend` or `frontend`, Railway looks at:
```
backend/
├── package.json  ← Railway detects Node.js ✅
├── nixpacks.toml ← Railway uses this for build ✅
└── railway.json  ← Railway uses this for deploy ✅
```

## Verification

After setting root directories:
1. Railway should detect Node.js automatically
2. Build should start using `nixpacks.toml`
3. Deploy should use commands from `railway.json`

## Alternative: Use Docker

If Nixpacks still has issues, you can use Docker instead:
1. Set Root Directory to `backend` or `frontend`
2. Railway will detect `Dockerfile` in that directory
3. Railway will build using Docker instead of Nixpacks

## Files Created

✅ `backend/railway.json` - Backend Railway config
✅ `frontend/railway.json` - Frontend Railway config  
✅ `backend/nixpacks.toml` - Backend build config (updated with openssl)
✅ `frontend/nixpacks.toml` - Frontend build config
✅ `backend/railway.toml` - Alternative backend config
✅ `frontend/railway.toml` - Alternative frontend config

## Next Steps

1. ✅ Code pushed to GitHub
2. ⏭️ Set Root Directory in Railway UI for each service
3. ⏭️ Add PostgreSQL database
4. ⏭️ Configure environment variables
5. ⏭️ Deploy!

The configuration files are now in place. The key step is **setting the Root Directory in Railway's UI**.

