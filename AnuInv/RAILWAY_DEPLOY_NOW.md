# Railway Deployment Guide - Quick Start

## ✅ Pre-Deployment Checklist

- [x] Railway configuration files created
- [x] Nixpacks configuration ready
- [x] Dockerfiles available (fallback option)
- [x] Code pushed to GitHub

## 🚀 Step-by-Step Railway Deployment

### Step 1: Create Railway Project

1. Go to [railway.app](https://railway.app)
2. Sign in with GitHub
3. Click **"New Project"**
4. Select **"Deploy from GitHub repo"**
5. Choose repository: `hopeIsCo0l/AnuInv`

### Step 2: Add PostgreSQL Database

1. In your Railway project, click **"New Service"**
2. Select **"Database"** → **"PostgreSQL"**
3. Railway will create the database automatically
4. **Copy the `DATABASE_URL`** from the database service variables

### Step 3: Deploy Backend Service

1. Click **"New Service"** → **"GitHub Repo"**
2. Select the same repository: `hopeIsCo0l/AnuInv`
3. **CRITICAL**: In service settings → **"Settings"** → **"Root Directory"**
   - Set to: `backend`
4. Go to **"Variables"** tab and add:

```env
DATABASE_URL=<from PostgreSQL service>
JWT_SECRET=<generate-random-secret-here>
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=<your-email@gmail.com>
SMTP_PASS=<your-gmail-app-password>
SMTP_FROM=noreply@anuinv.com
FRONTEND_URL=<will-add-after-frontend-deploys>
PORT=3000
NODE_ENV=production
```

5. Click **"Deploy"** - Railway will build and deploy automatically

### Step 4: Deploy Frontend Service

1. Click **"New Service"** → **"GitHub Repo"**
2. Select the same repository: `hopeIsCo0l/AnuInv`
3. **CRITICAL**: In service settings → **"Settings"** → **"Root Directory"**
   - Set to: `frontend`
4. Go to **"Variables"** tab and add:

```env
NEXT_PUBLIC_API_URL=<backend-railway-url>
PORT=3001
NODE_ENV=production
```

5. Get the backend URL from backend service → **"Settings"** → **"Generate Domain"**
6. Update `NEXT_PUBLIC_API_URL` with the backend URL
7. Click **"Deploy"**

### Step 5: Update Backend CORS

1. Go to backend service → **"Variables"**
2. Update `FRONTEND_URL` with the frontend Railway URL
3. Railway will automatically redeploy

### Step 6: Generate Domains

1. **Backend Service**: Settings → Generate Domain (e.g., `anuinv-backend.up.railway.app`)
2. **Frontend Service**: Settings → Generate Domain (e.g., `anuinv-frontend.up.railway.app`)

## 🔧 Environment Variables Reference

### Backend Variables
| Variable | Description | Example |
|----------|-------------|---------|
| `DATABASE_URL` | PostgreSQL connection string | `postgresql://...` (from Railway) |
| `JWT_SECRET` | Secret for JWT tokens | `your-super-secret-key-here` |
| `SMTP_HOST` | Email server host | `smtp.gmail.com` |
| `SMTP_PORT` | Email server port | `587` |
| `SMTP_USER` | Email username | `your-email@gmail.com` |
| `SMTP_PASS` | Email app password | `your-app-password` |
| `SMTP_FROM` | From email address | `noreply@anuinv.com` |
| `FRONTEND_URL` | Frontend URL for CORS | `https://anuinv-frontend.up.railway.app` |
| `PORT` | Server port | `3000` |
| `NODE_ENV` | Environment | `production` |

### Frontend Variables
| Variable | Description | Example |
|----------|-------------|---------|
| `NEXT_PUBLIC_API_URL` | Backend API URL | `https://anuinv-backend.up.railway.app` |
| `PORT` | Server port | `3001` |
| `NODE_ENV` | Environment | `production` |

## 🔑 Generate JWT Secret

Run this command to generate a secure JWT secret:
```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

## 📧 Gmail App Password Setup

1. Go to Google Account → Security
2. Enable 2-Step Verification
3. Go to App Passwords
4. Generate password for "Mail"
5. Use that password in `SMTP_PASS`

## ✅ Verification Steps

After deployment:

1. **Backend Health Check**:
   ```bash
   curl https://your-backend-url.up.railway.app/api
   ```
   Should return: `404` (which is correct - means server is running)

2. **Frontend Check**:
   - Visit your frontend Railway URL
   - Should see the Next.js app

3. **API Test**:
   ```bash
   curl -X POST https://your-backend-url.up.railway.app/api/auth/signup \
     -H "Content-Type: application/json" \
     -d '{"fullName":"Test User","email":"test@example.com","phone":"+1234567890","password":"password123"}'
   ```

## 🐛 Troubleshooting

### Issue: "Railpack could not determine how to build"
**Solution**: Make sure Root Directory is set correctly (`backend` or `frontend`)

### Issue: Database connection errors
**Solution**: 
- Verify `DATABASE_URL` is correct
- Check PostgreSQL service is running
- Ensure backend service has access to database

### Issue: CORS errors
**Solution**: 
- Verify `FRONTEND_URL` in backend matches frontend domain
- Check frontend `NEXT_PUBLIC_API_URL` matches backend domain

### Issue: Build fails
**Solution**: 
- Check Railway build logs
- Verify `package.json` exists in root directory
- Try using Docker instead: Railway will auto-detect `Dockerfile`

## 📚 Additional Resources

- Railway Docs: https://docs.railway.app
- Project Repository: https://github.com/hopeIsCo0l/AnuInv
- See `RAILWAY_FIX.md` for detailed troubleshooting

## 🎉 Success!

Once deployed, you'll have:
- ✅ Backend API running on Railway
- ✅ Frontend app running on Railway  
- ✅ PostgreSQL database managed by Railway
- ✅ Automatic deployments on git push
- ✅ HTTPS enabled by default

Your AnuInv Sys application is now live! 🚀

