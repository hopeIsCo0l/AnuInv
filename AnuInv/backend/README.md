# AnuInv Sys Backend

NestJS backend application for AnuInv Sys - Candy Factory Management System.

## Setup

1. Install dependencies:
```bash
npm install
```

2. Create `.env` file (see `.env.example` for reference)

3. Generate Prisma client:
```bash
npm run prisma:generate
```

4. Run database migrations:
```bash
npm run prisma:migrate
```

5. Start development server:
```bash
npm run start:dev
```

## Environment Variables

- `DATABASE_URL` - PostgreSQL connection string
- `JWT_SECRET` - Secret key for JWT tokens
- `JWT_EXPIRES_IN` - JWT token expiration time
- `OTP_EXPIRES_IN_MINUTES` - OTP expiration time in minutes
- `SMTP_HOST` - SMTP server host
- `SMTP_PORT` - SMTP server port
- `SMTP_USER` - SMTP username
- `SMTP_PASS` - SMTP password
- `SMTP_FROM` - Email sender address
- `PORT` - Server port (default: 3000)
- `NODE_ENV` - Environment (development/production)

## API Documentation

The API is available at `http://localhost:3000/api`

### Authentication Endpoints
- `POST /api/auth/signup` - Register new user
- `POST /api/auth/verify-otp` - Verify OTP
- `POST /api/auth/signin` - Sign in
- `GET /api/auth/profile` - Get current user (Protected)

### User Endpoints
- `GET /api/users` - Get all users (Role-based)
- `GET /api/users/:id` - Get user by ID (Role-based)
- `PUT /api/users/:id` - Update user (Role-based)
- `DELETE /api/users/:id` - Delete user (Yer only)

