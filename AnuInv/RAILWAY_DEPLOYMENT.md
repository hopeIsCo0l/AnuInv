# Railway Deployment Guide - AnuInv Sys

This guide will help you deploy AnuInv Sys on Railway.

## Prerequisites

- [ ] Railway account (sign up at [railway.app](https://railway.app))
- [ ] GitHub account (for connecting your repository)
- [ ] Railway CLI (optional, for local testing)

## Deployment Steps

### Step 1: Prepare Your Repository

1. **Push your code to GitHub** (if not already done):
   ```bash
   git add .
   git commit -m "Add Docker and Railway configuration"
   git push origin main
   ```

### Step 2: Create Railway Project

1. **Login to Railway**:
   - Go to [railway.app](https://railway.app)
   - Sign in with GitHub

2. **Create New Project**:
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Choose your `AnuInv` repository
   - Railway will automatically detect your project

### Step 3: Deploy Backend Service

1. **Add Backend Service**:
   - In your Railway project, click "New Service"
   - Select "GitHub Repo" and choose your repository
   - Set the **Root Directory** to `backend`
   - Railway will automatically detect the Node.js application

2. **Configure Backend Environment Variables**:
   
   Add the following environment variables in Railway dashboard:
   
   ```env
   DATABASE_URL=${{Postgres.DATABASE_URL}}
   JWT_SECRET=your-super-secret-jwt-key-change-this-min-32-characters
   JWT_EXPIRES_IN=7d
   OTP_EXPIRES_IN_MINUTES=10
   SMTP_HOST=smtp.gmail.com
   SMTP_PORT=587
   SMTP_USER=your-email@gmail.com
   SMTP_PASS=your-app-password
   SMTP_FROM=noreply@anuinv.com
   PORT=3000
   NODE_ENV=production
   FRONTEND_URL=https://your-frontend-domain.railway.app
   ```

3. **Add PostgreSQL Database**:
   - In your Railway project, click "New Service"
   - Select "Database" → "Add PostgreSQL"
   - Railway will automatically create a PostgreSQL database
   - The `DATABASE_URL` will be automatically available as `${{Postgres.DATABASE_URL}}`

4. **Configure Build Settings**:
   - **Build Command**: `npm install && npx prisma generate && npm run build`
   - **Start Command**: `sh -c 'npx prisma migrate deploy && npm run start:prod'`
   - **Root Directory**: `backend`

### Step 4: Deploy Frontend Service

1. **Add Frontend Service**:
   - In your Railway project, click "New Service"
   - Select "GitHub Repo" and choose your repository
   - Set the **Root Directory** to `frontend`

2. **Configure Frontend Environment Variables**:
   
   Add the following environment variables:
   
   ```env
   NEXT_PUBLIC_API_URL=https://your-backend-domain.railway.app/api
   NODE_ENV=production
   ```

3. **Configure Build Settings**:
   - **Build Command**: `npm install && npm run build`
   - **Start Command**: `npm run start`
   - **Root Directory**: `frontend`

### Step 5: Configure Domains

1. **Backend Domain**:
   - Go to your backend service settings
   - Click "Generate Domain"
   - Copy the domain (e.g., `anuinv-backend.railway.app`)
   - Update `FRONTEND_URL` in backend environment variables
   - Update `NEXT_PUBLIC_API_URL` in frontend environment variables

2. **Frontend Domain**:
   - Go to your frontend service settings
   - Click "Generate Domain"
   - Copy the domain (e.g., `anuinv-frontend.railway.app`)
   - Update `FRONTEND_URL` in backend environment variables

### Step 6: Deploy and Verify

1. **Deploy Services**:
   - Railway will automatically deploy when you push to GitHub
   - Or manually trigger deployment from Railway dashboard

2. **Check Deployment Logs**:
   - Go to each service's "Deployments" tab
   - Check logs for any errors
   - Ensure migrations run successfully

3. **Test the API**:
   ```bash
   curl https://your-backend-domain.railway.app/api/auth/signup \
     -H "Content-Type: application/json" \
     -d '{
       "fullName": "Test User",
       "email": "test@example.com",
       "phone": "+1234567890",
       "password": "password123"
     }'
   ```

## Railway Configuration Files

### Backend (`backend/nixpacks.toml`)
- Configures build and start commands
- Handles Prisma migrations automatically

### Frontend (`frontend/nixpacks.toml`)
- Configures Next.js build and start

### Root (`railway.json` and `railway.toml`)
- Global Railway configuration
- Health check settings

## Environment Variables Reference

### Backend Required Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `DATABASE_URL` | PostgreSQL connection string | `postgresql://user:pass@host:5432/db` |
| `JWT_SECRET` | Secret key for JWT tokens | `your-secret-key-min-32-chars` |
| `JWT_EXPIRES_IN` | JWT token expiration | `7d` |
| `PORT` | Server port | `3000` |
| `FRONTEND_URL` | Frontend URL for CORS | `https://frontend.railway.app` |

### Backend Optional Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `OTP_EXPIRES_IN_MINUTES` | OTP expiration time | `10` |
| `SMTP_HOST` | SMTP server host | `smtp.gmail.com` |
| `SMTP_PORT` | SMTP server port | `587` |
| `SMTP_USER` | SMTP username | - |
| `SMTP_PASS` | SMTP password | - |
| `SMTP_FROM` | Email sender address | `noreply@anuinv.com` |

### Frontend Required Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `NEXT_PUBLIC_API_URL` | Backend API URL | `https://backend.railway.app/api` |

## Troubleshooting

### Database Migration Issues

If migrations fail:
1. Check database connection in Railway logs
2. Verify `DATABASE_URL` is correct
3. Manually run migrations: `npx prisma migrate deploy`

### Build Failures

1. **Check build logs** in Railway dashboard
2. **Verify Node.js version** (should be 18+)
3. **Check for missing dependencies** in package.json
4. **Ensure Prisma client is generated** before build

### CORS Issues

1. Update `FRONTEND_URL` in backend environment variables
2. Ensure frontend domain matches the CORS configuration
3. Check backend CORS settings in `main.ts`

### Environment Variables Not Working

1. **Restart services** after changing environment variables
2. **Check variable names** (case-sensitive)
3. **Verify variable values** don't have extra spaces
4. **Use Railway's variable reference** for database: `${{Postgres.DATABASE_URL}}`

### Port Issues

- Railway automatically assigns ports
- Use `PORT` environment variable or Railway's `PORT` variable
- Backend should listen on `process.env.PORT || 3000`

## Monitoring and Logs

1. **View Logs**:
   - Go to service → "Deployments" → Click on deployment → "View Logs"

2. **Monitor Metrics**:
   - Railway provides CPU, Memory, and Network metrics
   - Check "Metrics" tab in each service

3. **Health Checks**:
   - Railway automatically health checks your services
   - Configure health check endpoint in `railway.toml`

## Updating Deployment

1. **Push to GitHub**:
   ```bash
   git add .
   git commit -m "Update application"
   git push origin main
   ```

2. **Railway Auto-Deploy**:
   - Railway automatically detects changes
   - Triggers new deployment
   - Updates services with new code

## Custom Domains

1. **Add Custom Domain**:
   - Go to service settings
   - Click "Custom Domain"
   - Add your domain
   - Configure DNS records as instructed

2. **SSL Certificates**:
   - Railway automatically provisions SSL certificates
   - HTTPS is enabled by default

## Cost Optimization

1. **Free Tier**:
   - Railway offers a free tier with $5 credit/month
   - Perfect for development and small projects

2. **Resource Limits**:
   - Monitor resource usage in Railway dashboard
   - Adjust service resources as needed

## Support

- **Railway Documentation**: [docs.railway.app](https://docs.railway.app)
- **Railway Discord**: [discord.gg/railway](https://discord.gg/railway)
- **GitHub Issues**: Create an issue in your repository

## Next Steps

1. ✅ Deploy backend service
2. ✅ Deploy frontend service
3. ✅ Configure domains
4. ✅ Set up environment variables
5. ✅ Test the application
6. ✅ Monitor logs and metrics
7. ✅ Set up custom domains (optional)
8. ✅ Configure CI/CD (optional)

Happy deploying! 🚀

