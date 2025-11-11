# Quick Start Guide - Run AnuInv Sys Locally

## Prerequisites Checklist

- [ ] PostgreSQL installed and running
- [ ] Node.js (v18+) installed
- [ ] npm installed

## Step 1: Database Setup

1. **Start PostgreSQL** (if not already running)

2. **Create the database**:
   ```sql
   CREATE DATABASE anuinv_db;
   ```

3. **Update `.env` file** in `backend/` directory:
   ```env
   DATABASE_URL="postgresql://YOUR_USERNAME:YOUR_PASSWORD@localhost:5432/anuinv_db?schema=public"
   ```
   
   Replace:
   - `YOUR_USERNAME` with your PostgreSQL username (usually `postgres`)
   - `YOUR_PASSWORD` with your PostgreSQL password

## Step 2: Run Database Migrations

```bash
cd backend
npm run prisma:migrate
```

This will create all the database tables.

## Step 3: Start Backend Server

```bash
cd backend
npm run start:dev
```

Backend will run on: http://localhost:3000

## Step 4: Start Frontend Server

Open a **new terminal** and run:

```bash
cd frontend
npm run dev
```

Frontend will run on: http://localhost:3001

## Step 5: Test the API

### Test Signup
```bash
curl -X POST http://localhost:3000/api/auth/signup \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "John Doe",
    "email": "john@example.com",
    "phone": "+1234567890",
    "password": "password123"
  }'
```

### Test Signin
```bash
curl -X POST http://localhost:3000/api/auth/signin \
  -H "Content-Type: application/json" \
  -d '{
    "emailOrPhone": "john@example.com",
    "password": "password123"
  }'
```

## Troubleshooting

### Database Connection Error
- Make sure PostgreSQL is running
- Check your DATABASE_URL in `.env`
- Verify database `anuinv_db` exists

### Port Already in Use
- Change PORT in backend `.env` file
- Or stop the process using port 3000/3001

### Email Not Working
- Update SMTP settings in `.env` (optional - app will work without email)
- For Gmail, use App Password (not regular password)

### Prisma Migration Issues
- Make sure database is accessible
- Check DATABASE_URL format
- Try: `npx prisma migrate reset` (⚠️ deletes all data)

## What's Next?

1. Open http://localhost:3001 in your browser
2. Start building the frontend UI
3. Test API endpoints using Postman or curl
4. Check Prisma Studio: `npm run prisma:studio` (database GUI)

## Need Help?

- Check `SETUP.md` for detailed setup instructions
- Check `README.md` for project overview
- Check backend logs for errors
- Check browser console for frontend errors

