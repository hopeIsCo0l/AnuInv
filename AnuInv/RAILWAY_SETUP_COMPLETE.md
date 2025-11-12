# Railway Setup Complete! ✅

## Services Created

### ✅ Backend Service: `backend-api`
- **Status**: Linked and configured
- **Root Directory**: Auto-set to `backend/` (when linking from backend directory)
- **Service ID**: `16611105-e7b2-4c93-b12f-5c30163d9837`

### ✅ Frontend Service: `frontend`
- **Status**: Linked and configured  
- **Root Directory**: Auto-set to `frontend/` (when linking from frontend directory)
- **Service ID**: `7414e85c-5e66-4087-97c8-48091a1530b0`

## Environment Variables Set

### Backend (`backend-api`)
✅ `SMTP_HOST=smtp.gmail.com`  
✅ `SMTP_PORT=587`  
✅ `SMTP_FROM=noreply@anuinv.com`  
✅ `PORT=3000`  
✅ `NODE_ENV=production`  
✅ `JWT_SECRET=9fb6c7a3bce02344c8467d7c82cd9996366711ff14f6c73a8ef717f944a9968b`

### Frontend (`frontend`)
✅ `PORT=3001`  
✅ `NODE_ENV=production`

## ⚠️ Still Need to Set Manually

### Backend - After Creating PostgreSQL Database:
```powershell
cd backend
railway variables --set "DATABASE_URL=<from-postgres-service>"
railway variables --set "SMTP_USER=<your-email@gmail.com>"
railway variables --set "SMTP_PASS=<gmail-app-password>"
railway variables --set "FRONTEND_URL=<frontend-railway-url-after-deploy>"
```

### Frontend - After Backend Deploys:
```powershell
cd frontend
railway variables --set "NEXT_PUBLIC_API_URL=<backend-railway-url>"
```

## Next Steps

1. **Create PostgreSQL Database**:
   - Go to Railway UI → New Service → Database → PostgreSQL
   - Copy the `DATABASE_URL`

2. **Set Remaining Backend Variables**:
   - `DATABASE_URL` (from PostgreSQL)
   - `SMTP_USER` (your email)
   - `SMTP_PASS` (Gmail app password)
   - `FRONTEND_URL` (after frontend deploys)

3. **Deploy Backend**:
   ```powershell
   cd backend
   railway up
   ```

4. **Deploy Frontend**:
   ```powershell
   cd frontend
   railway up
   ```

5. **Set Frontend API URL**:
   - Get backend URL from Railway UI
   - Set `NEXT_PUBLIC_API_URL` in frontend variables
   - Set `FRONTEND_URL` in backend variables

## Root Directory Fix ✅

The root directory issue is **FIXED**! When you link a service from a directory (e.g., `backend/` or `frontend/`), Railway automatically sets that as the root directory. This solves the "could not determine how to build" error.

## Verification

Check service status:
```powershell
cd backend
railway status
# Should show: Service: backend-api

cd ../frontend  
railway status
# Should show: Service: frontend
```

## Ready to Deploy! 🚀

Your services are configured and ready. Just add the PostgreSQL database and remaining variables, then deploy!

