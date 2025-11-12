# Fix: Create Separate Services for Backend and Frontend

## Problem
Both backend and frontend are linked to the same service "AnuInv". They need to be separate services.

## Solution: Create Separate Services

### Option 1: Via Railway UI (Recommended)

1. **Go to Railway Dashboard**
   - Open project: `capable-contentment`
   - You'll see one service: `AnuInv`

2. **Create Backend Service**
   - Click "New Service" → "GitHub Repo"
   - Select repository: `hopeIsCo0l/AnuInv`
   - Name it: `backend`
   - **IMPORTANT**: Set Root Directory to: `backend`
   - Save

3. **Create Frontend Service**
   - Click "New Service" → "GitHub Repo"
   - Select repository: `hopeIsCo0l/AnuInv`
   - Name it: `frontend`
   - **IMPORTANT**: Set Root Directory to: `frontend`
   - Save

4. **Delete or Rename Old Service**
   - The old "AnuInv" service can be deleted or renamed
   - Or unlink it using CLI: `railway unlink`

### Option 2: Via CLI (Create New Services)

#### Step 1: Unlink Current Service
```powershell
cd backend
railway unlink
```

#### Step 2: Create New Backend Service
```powershell
cd backend
railway link
# When prompted:
# - Select project: capable-contentment
# - Create new service: backend
# - Root directory will be auto-set to backend/
```

#### Step 3: Create New Frontend Service
```powershell
cd ../frontend
railway link
# When prompted:
# - Select project: capable-contentment
# - Create new service: frontend
# - Root directory will be auto-set to frontend/
```

### Step 4: Set Environment Variables

#### Backend Variables
```powershell
cd backend
railway variables set SMTP_HOST=smtp.gmail.com
railway variables set SMTP_PORT=587
railway variables set SMTP_FROM=noreply@anuinv.com
railway variables set PORT=3000
railway variables set NODE_ENV=production

# Generate JWT secret
$secret = node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
railway variables set JWT_SECRET=$secret
```

#### Frontend Variables
```powershell
cd ../frontend
railway variables set PORT=3001
railway variables set NODE_ENV=production
```

### Step 5: Create PostgreSQL Database

1. In Railway UI → New Service → Database → PostgreSQL
2. Copy `DATABASE_URL`
3. Set it in backend:
```powershell
cd backend
railway variables set DATABASE_URL=<paste-url-here>
```

### Step 6: Deploy

```powershell
# Backend
cd backend
railway up

# Frontend (after backend deploys)
cd ../frontend
railway up
```

## Verification

After creating separate services:

```powershell
# Check backend service
cd backend
railway status
# Should show: Service: backend

# Check frontend service
cd ../frontend
railway status
# Should show: Service: frontend
```

## Why Separate Services?

- ✅ Each service can have its own root directory
- ✅ Independent scaling and configuration
- ✅ Separate environment variables
- ✅ Independent deployments
- ✅ Better organization

