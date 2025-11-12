# Railway CLI Configuration Guide

## Prerequisites
- Railway CLI installed ✅ (`railway --version` shows 4.10.0)
- GitHub repository: `hopeIsCo0l/AnuInv`

## Step 1: Login to Railway CLI

```bash
railway login
```

This will open a browser for authentication.

## Step 2: Link Backend Service

```bash
cd backend
railway link
```

When prompted:
- Select your Railway project
- If service doesn't exist, create new service named "backend"

## Step 3: Set Root Directory for Backend

The root directory is automatically set when you run `railway link` from the `backend` directory.

Verify with:
```bash
railway status
```

## Step 4: Configure Backend Environment Variables

```bash
railway variables set DATABASE_URL=${{Postgres.DATABASE_URL}}
railway variables set JWT_SECRET=$(node -e "console.log(require('crypto').randomBytes(32).toString('hex'))")
railway variables set SMTP_HOST=smtp.gmail.com
railway variables set SMTP_PORT=587
railway variables set SMTP_USER=your-email@gmail.com
railway variables set SMTP_PASS=your-app-password
railway variables set SMTP_FROM=noreply@anuinv.com
railway variables set PORT=3000
railway variables set NODE_ENV=production
```

## Step 5: Link Frontend Service

```bash
cd ../frontend
railway link
```

When prompted:
- Select the same Railway project
- Create new service named "frontend"

## Step 6: Configure Frontend Environment Variables

```bash
railway variables set NEXT_PUBLIC_API_URL=https://your-backend-url.up.railway.app
railway variables set PORT=3001
railway variables set NODE_ENV=production
```

## Step 7: Deploy Services

### Deploy Backend:
```bash
cd ../backend
railway up
```

### Deploy Frontend:
```bash
cd ../frontend
railway up
```

## Alternative: Use railway.json for Root Directory

If Railway doesn't detect the root directory automatically, create `railway.json` in each service directory:

**backend/railway.json** (already exists):
```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "sh -c 'npx prisma db push --accept-data-loss --skip-generate && npm run start:prod'",
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 10
  }
}
```

## Useful Railway CLI Commands

```bash
# Check current service status
railway status

# View logs
railway logs

# Open service in browser
railway open

# List all services in project
railway service list

# View environment variables
railway variables

# Deploy
railway up

# Deploy without build cache
railway up --no-cache
```

## Troubleshooting

If `railway link` doesn't set root directory correctly:

1. Check current directory:
   ```bash
   pwd  # Should be backend/ or frontend/
   ```

2. Verify service is linked:
   ```bash
   railway status
   ```

3. If root directory is wrong, you may need to:
   - Delete service in Railway UI
   - Recreate via CLI from correct directory

## Quick Setup Script

Save this as `setup-railway.sh`:

```bash
#!/bin/bash

# Login
railway login

# Setup Backend
cd backend
railway link
railway variables set DATABASE_URL=${{Postgres.DATABASE_URL}}
railway variables set JWT_SECRET=$(node -e "console.log(require('crypto').randomBytes(32).toString('hex'))")
railway variables set SMTP_HOST=smtp.gmail.com
railway variables set SMTP_PORT=587
railway variables set SMTP_FROM=noreply@anuinv.com
railway variables set PORT=3000
railway variables set NODE_ENV=production

# Setup Frontend
cd ../frontend
railway link
railway variables set PORT=3001
railway variables set NODE_ENV=production

echo "✅ Railway services configured!"
echo "Run 'railway up' in backend/ and frontend/ to deploy"
```

