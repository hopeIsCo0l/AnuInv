# AnuInv Sys - Setup Guide

This guide will help you set up the AnuInv Sys project from scratch.

## Prerequisites

Before you begin, make sure you have the following installed:

- **Node.js** (v18 or higher) - [Download](https://nodejs.org/)
- **PostgreSQL** (v14 or higher) - [Download](https://www.postgresql.org/download/)
- **npm** (comes with Node.js) or **yarn**
- **Git** (optional, for version control)

## Step 1: Database Setup

1. **Install PostgreSQL** if you haven't already
2. **Create a new database**:
   ```sql
   CREATE DATABASE anuinv_db;
   ```
3. **Note your database credentials** (username, password, host, port)

## Step 2: Backend Setup

1. **Navigate to the backend directory**:
   ```bash
   cd backend
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Create a `.env` file** in the `backend` directory:
   ```env
   DATABASE_URL="postgresql://username:password@localhost:5432/anuinv_db?schema=public"
   JWT_SECRET="your-super-secret-jwt-key-change-this-in-production-min-32-chars"
   JWT_EXPIRES_IN="7d"
   OTP_EXPIRES_IN_MINUTES=10
   SMTP_HOST="smtp.gmail.com"
   SMTP_PORT=587
   SMTP_USER="your-email@gmail.com"
   SMTP_PASS="your-app-password"
   SMTP_FROM="noreply@anuinv.com"
   PORT=3000
   NODE_ENV=development
   FRONTEND_URL="http://localhost:3001"
   ```

   **Note**: 
   - Replace `username` and `password` with your PostgreSQL credentials
   - For Gmail SMTP, you'll need to generate an [App Password](https://support.google.com/accounts/answer/185833)
   - Change `JWT_SECRET` to a secure random string (at least 32 characters)

4. **Generate Prisma Client**:
   ```bash
   npm run prisma:generate
   ```

5. **Run database migrations**:
   ```bash
   npm run prisma:migrate
   ```
   This will create all the database tables.

6. **Start the backend server**:
   ```bash
   npm run start:dev
   ```

   The backend should now be running on `http://localhost:3000`

## Step 3: Frontend Setup

1. **Navigate to the frontend directory** (in a new terminal):
   ```bash
   cd frontend
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Create a `.env.local` file** in the `frontend` directory:
   ```env
   NEXT_PUBLIC_API_URL=http://localhost:3000/api
   ```

4. **Start the frontend development server**:
   ```bash
   npm run dev
   ```

   The frontend should now be running on `http://localhost:3001`

## Step 4: Verify Installation

1. **Check backend**: Open `http://localhost:3000/api` in your browser (should return 404, which is normal for the root endpoint)
2. **Check frontend**: Open `http://localhost:3001` in your browser (should show the Next.js default page)

## Testing the API

You can test the authentication endpoints using curl or Postman:

### 1. Sign Up
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

### 2. Verify OTP
```bash
curl -X POST http://localhost:3000/api/auth/verify-otp \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "user-id-from-signup",
    "otpCode": "123456"
  }'
```

### 3. Sign In
```bash
curl -X POST http://localhost:3000/api/auth/signin \
  -H "Content-Type: application/json" \
  -d '{
    "emailOrPhone": "john@example.com",
    "password": "password123"
  }'
```

### 4. Get Profile (Protected)
```bash
curl -X GET http://localhost:3000/api/auth/profile \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## Common Issues

### Database Connection Error
- Make sure PostgreSQL is running
- Verify your database credentials in `.env`
- Check that the database `anuinv_db` exists

### Port Already in Use
- Change the `PORT` in backend `.env` file
- Or stop the process using port 3000/3001

### Email Not Sending
- Check your SMTP credentials
- For Gmail, make sure you're using an App Password, not your regular password
- Check your email provider's SMTP settings

### Prisma Migration Issues
- Make sure your database is accessible
- Try resetting the database: `npx prisma migrate reset` (⚠️ This will delete all data)

## Next Steps

Once the setup is complete, you can:

1. **Explore the API**: Check the API endpoints in `backend/src`
2. **Build the frontend**: Start building the React/Next.js frontend
3. **Add features**: Implement warehouse management, inventory, payroll, etc.

## Development Commands

### Backend
```bash
npm run start:dev    # Start development server
npm run build        # Build for production
npm run start:prod   # Start production server
npm run prisma:studio  # Open Prisma Studio (database GUI)
npm run lint         # Run ESLint
```

### Frontend
```bash
npm run dev      # Start development server
npm run build    # Build for production
npm run start    # Start production server
npm run lint     # Run ESLint
```

## Support

If you encounter any issues, please check:
1. The error messages in the terminal
2. The browser console (for frontend issues)
3. The database connection
4. The environment variables

For more information, see the main [README.md](./README.md) file.

