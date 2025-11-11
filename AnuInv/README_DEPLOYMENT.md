# Quick Railway Deployment Guide

## 🚀 Deploy to Railway in 5 Minutes

### Step 1: Push to GitHub
```bash
git add .
git commit -m "Add Docker and Railway configuration"
git push origin main
```

### Step 2: Create Railway Project

1. Go to [railway.app](https://railway.app) and sign in with GitHub
2. Click "New Project" → "Deploy from GitHub repo"
3. Select your `AnuInv` repository

### Step 3: Add PostgreSQL Database

1. In your Railway project, click "New Service"
2. Select "Database" → "Add PostgreSQL"
3. Railway will automatically create the database

### Step 4: Deploy Backend

1. Click "New Service" → "GitHub Repo" → Select your repo
2. Set **Root Directory** to `backend`
3. Add environment variables:
   ```
   DATABASE_URL=${{Postgres.DATABASE_URL}}
   JWT_SECRET=your-super-secret-jwt-key-min-32-characters
   JWT_EXPIRES_IN=7d
   PORT=3000
   NODE_ENV=production
   FRONTEND_URL=https://your-frontend.railway.app
   ```
4. Railway will auto-detect and deploy

### Step 5: Deploy Frontend

1. Click "New Service" → "GitHub Repo" → Select your repo
2. Set **Root Directory** to `frontend`
3. Add environment variables:
   ```
   NEXT_PUBLIC_API_URL=https://your-backend.railway.app/api
   NODE_ENV=production
   ```
4. Generate domain and update backend `FRONTEND_URL`

### Step 6: Test

1. Visit your frontend URL
2. Test API: `curl https://your-backend.railway.app/api`

## 📚 Detailed Guide

See [RAILWAY_DEPLOYMENT.md](./RAILWAY_DEPLOYMENT.md) for detailed instructions.

## 🐳 Local Docker Development

```bash
docker-compose up
```

This will start:
- PostgreSQL on port 5432
- Backend on port 3000
- Frontend on port 3001

## 📝 Environment Variables

### Backend
- `DATABASE_URL` - PostgreSQL connection string
- `JWT_SECRET` - JWT secret key (min 32 chars)
- `FRONTEND_URL` - Frontend URL for CORS
- `SMTP_*` - Email configuration (optional)

### Frontend
- `NEXT_PUBLIC_API_URL` - Backend API URL

## 🔍 Troubleshooting

- Check Railway deployment logs
- Verify environment variables
- Ensure database migrations ran
- Check CORS configuration

## 📖 More Information

- [Railway Documentation](https://docs.railway.app)
- [Full Deployment Guide](./RAILWAY_DEPLOYMENT.md)
- [Deployment Checklist](./DEPLOYMENT_CHECKLIST.md)

