# API Testing Guide

## ✅ Backend is Running!

The 404 error on `http://localhost:3000/` is **expected** because:
- Your API is prefixed with `/api`
- The root path `/` doesn't have a route handler
- This confirms the backend is running correctly!

## Test the API Endpoints

### 1. Test API Root
```bash
curl http://localhost:3000/api
```

### 2. Test Signup Endpoint
```bash
curl -X POST http://localhost:3000/api/auth/signup \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "Test User",
    "email": "test@example.com",
    "phone": "+1234567890",
    "password": "password123"
  }'
```

### 3. Test Signin Endpoint
```bash
curl -X POST http://localhost:3000/api/auth/signin \
  -H "Content-Type: application/json" \
  -d '{
    "emailOrPhone": "test@example.com",
    "password": "password123"
  }'
```

### 4. Test Users Endpoint (Protected)
```bash
# First get a token from signin, then:
curl http://localhost:3000/api/users \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## Frontend

The frontend should be running on:
- **http://localhost:3001**

Open this in your browser to see the Next.js application.

## Available Endpoints

### Authentication
- `POST /api/auth/signup` - Register new user
- `POST /api/auth/verify-otp` - Verify OTP code
- `POST /api/auth/signin` - Sign in user
- `GET /api/auth/profile` - Get current user (Protected)

### Users
- `GET /api/users` - Get all users (Role-based)
- `GET /api/users/:id` - Get user by ID (Role-based)
- `PUT /api/users/:id` - Update user (Role-based)
- `DELETE /api/users/:id` - Delete user (Yer only)

## Next Steps

1. ✅ Backend is running - confirmed!
2. ✅ Test API endpoints using curl or Postman
3. ✅ Open frontend at http://localhost:3001
4. ✅ Start building the frontend UI
5. ✅ Test the full authentication flow

## Troubleshooting

If you see errors:
- Check `docker-compose logs backend` for backend logs
- Check `docker-compose logs frontend` for frontend logs
- Verify all containers are running: `docker-compose ps`

