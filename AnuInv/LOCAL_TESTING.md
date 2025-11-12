# Local Testing Guide - AnuInv Sys

## Quick Start - Test Locally

### Option 1: Using Docker Compose (Easiest)

```powershell
# Start everything (database + backend + frontend)
docker-compose up

# Or run in background
docker-compose up -d
```

This will start:
- PostgreSQL database on port 5432
- Backend API on http://localhost:3000
- Frontend on http://localhost:3001

### Option 2: Manual Setup (For Development)

#### 1. Start PostgreSQL Database

Make sure PostgreSQL is running locally, or use Docker:

```powershell
docker run -d --name anuinv-postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=anuinv_db -p 5432:5432 postgres:15-alpine
```

#### 2. Setup Backend

```powershell
cd backend

# Install dependencies
npm install

# Create .env file
@"
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/anuinv_db?schema=public
JWT_SECRET=local-dev-secret-key-change-in-production-min-32-chars
JWT_EXPIRES_IN=7d
OTP_EXPIRES_IN_MINUTES=10
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password
SMTP_FROM=noreply@anuinv.com
PORT=3000
NODE_ENV=development
FRONTEND_URL=http://localhost:3001
"@ | Out-File -FilePath .env -Encoding utf8

# Generate Prisma Client
npm run prisma:generate

# Run migrations
npm run prisma:migrate

# Start backend
npm run start:dev
```

Backend will run on: **http://localhost:3000**

#### 3. Setup Frontend (New Terminal)

```powershell
cd frontend

# Install dependencies
npm install

# Create .env.local file
@"
NEXT_PUBLIC_API_URL=http://localhost:3000/api
"@ | Out-File -FilePath .env.local -Encoding utf8

# Start frontend
npm run dev
```

Frontend will run on: **http://localhost:3001**

## Test the Application

### 1. Open Frontend
Visit: **http://localhost:3001**

### 2. Test Backend API

**Signup:**
```powershell
curl -X POST http://localhost:3000/api/auth/signup `
  -H "Content-Type: application/json" `
  -d '{\"fullName\":\"Test User\",\"email\":\"test@example.com\",\"phone\":\"+1234567890\",\"password\":\"password123\"}'
```

**Signin:**
```powershell
curl -X POST http://localhost:3000/api/auth/signin `
  -H "Content-Type: application/json" `
  -d '{\"emailOrPhone\":\"test@example.com\",\"password\":\"password123\"}'
```

**Get Profile (with token):**
```powershell
curl -X GET http://localhost:3000/api/users/profile `
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## Verify Everything Works

✅ **Backend**: http://localhost:3000/api (should return 404 - that's normal)  
✅ **Frontend**: http://localhost:3001 (should show Next.js page)  
✅ **Database**: Check with Prisma Studio: `cd backend && npm run prisma:studio`

## Troubleshooting

### Port Already in Use
- Change PORT in backend `.env` or frontend config
- Or stop the process using those ports

### Database Connection Error
- Make sure PostgreSQL is running
- Check DATABASE_URL in backend `.env`
- Verify database `anuinv_db` exists

### CORS Errors
- Make sure FRONTEND_URL in backend `.env` matches frontend URL
- Default: `http://localhost:3001`

### Email Not Working
- SMTP settings are optional for local testing
- App will work without email (OTP won't send)

## Next Steps

1. ✅ Test all API endpoints
2. ✅ Build frontend UI
3. ✅ Test full user flow
4. 🚀 Deploy to Vercel (frontend) + Backend hosting

## Ready for Vercel?

Once local testing is complete, we'll deploy:
- **Frontend** → Vercel (automatic Next.js deployment)
- **Backend** → Vercel Serverless Functions or separate backend hosting

Let's test locally first! 🚀

