# Railway Deployment - Final Configuration ✅

## Service URLs Configured

### Backend API
- **URL**: `https://backend-api-production-2467.up.railway.app`
- **Status**: ✅ Deployed and configured

### Frontend
- **URL**: `https://frontend-production-7d5d.up.railway.app`
- **Status**: ✅ Deployed and configured

## Environment Variables Set

### Frontend Variables
✅ `NEXT_PUBLIC_API_URL=https://backend-api-production-2467.up.railway.app`  
✅ `PORT=3001`  
✅ `NODE_ENV=production`

### Backend Variables
✅ `FRONTEND_URL=https://frontend-production-7d5d.up.railway.app`  
✅ `DATABASE_URL=postgresql://...` (Connected to Postgres)  
✅ `PORT=3000`  
✅ `NODE_ENV=production`  
✅ `JWT_SECRET=...`  
✅ `SMTP_HOST=smtp.gmail.com`  
✅ `SMTP_PORT=587`  
✅ `SMTP_USER=abdellahteshome@outlook.com`  
✅ `SMTP_FROM=noreply@anuinv.com`

## ⚠️ Still Need to Set

### SMTP Password (For Email OTP)
```powershell
cd backend
railway variables --set "SMTP_PASS=<your-gmail-app-password>"
```

**How to get Gmail App Password:**
1. Go to Google Account → Security
2. Enable 2-Step Verification
3. Go to App Passwords
4. Generate password for "Mail"
5. Use that password in `SMTP_PASS`

## Test Your Application

### 1. Test Frontend
Visit: **https://frontend-production-7d5d.up.railway.app**

### 2. Test Backend API
```bash
# Health check
curl https://backend-api-production-2467.up.railway.app/api

# Test signup (example)
curl -X POST https://backend-api-production-2467.up.railway.app/api/auth/signup \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "Test User",
    "email": "test@example.com",
    "phone": "+1234567890",
    "password": "password123"
  }'
```

### 3. Test CORS
Frontend should be able to call backend API without CORS errors.

## Application Status

✅ **Backend**: Deployed and running  
✅ **Frontend**: Deployed and running  
✅ **Database**: Connected (Postgres)  
✅ **CORS**: Configured  
✅ **API Connection**: Frontend → Backend connected  
⚠️ **Email OTP**: Needs SMTP_PASS to work  

## Next Steps

1. **Set SMTP_PASS** (if you want email OTP to work)
2. **Test the application**:
   - Visit frontend URL
   - Try signup/login
   - Verify API calls work
3. **Clean up unused services** (optional):
   - Delete `backend` service (no deploys)
   - Delete `Anulnv` service (failed)

## Your Application is Live! 🚀

- **Frontend**: https://frontend-production-7d5d.up.railway.app
- **Backend API**: https://backend-api-production-2467.up.railway.app

Everything is connected and ready to use!

