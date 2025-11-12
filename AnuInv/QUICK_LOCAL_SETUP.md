# Quick Local Setup - Without Docker

## Option 1: Start Docker Desktop (If You Have It)

1. **Start Docker Desktop** application on Windows
2. Wait for it to fully start (whale icon in system tray)
3. Then run: `docker-compose up`

## Option 2: Manual Setup (No Docker Needed)

### Step 1: Start PostgreSQL

**Option A: If PostgreSQL is installed locally:**
```powershell
# Check if PostgreSQL is running
Get-Service -Name postgresql*

# If not running, start it
Start-Service postgresql-x64-15  # Adjust version number
```

**Option B: Use Docker just for PostgreSQL:**
```powershell
docker run -d --name anuinv-postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=anuinv_db -p 5432:5432 postgres:15-alpine
```

**Option C: Install PostgreSQL locally:**
- Download from: https://www.postgresql.org/download/windows/
- Install and start the service

### Step 2: Setup Backend

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
SMTP_USER=
SMTP_PASS=
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

### Step 3: Setup Frontend (New Terminal)

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

1. **Open Frontend**: http://localhost:3001
2. **Test Backend API**: http://localhost:3000/api

## Troubleshooting

### PostgreSQL Connection Error
- Make sure PostgreSQL is running
- Check DATABASE_URL in backend/.env
- Verify database `anuinv_db` exists:
  ```sql
  CREATE DATABASE anuinv_db;
  ```

### Port Already in Use
- Change PORT in backend/.env
- Or stop the process using port 3000/3001

### Prisma Migration Issues
```powershell
cd backend
npx prisma migrate reset  # ⚠️ This deletes all data
npx prisma migrate dev
```

## Quick Commands

**Backend:**
```powershell
cd backend
npm run start:dev        # Start dev server
npm run prisma:studio    # Open database GUI
```

**Frontend:**
```powershell
cd frontend
npm run dev              # Start dev server
```

Ready to test! 🚀

