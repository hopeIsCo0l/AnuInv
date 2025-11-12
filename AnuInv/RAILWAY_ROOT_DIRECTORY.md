# Railway Deployment - Root Directory Configuration

## Important: Railway Service Configuration

When deploying on Railway, you **MUST** configure the **Root Directory** for each service:

### Backend Service
- **Root Directory**: `backend`
- Railway will look for `package.json` in the `backend/` directory
- Uses `backend/nixpacks.toml` for build configuration

### Frontend Service  
- **Root Directory**: `frontend`
- Railway will look for `package.json` in the `frontend/` directory
- Uses `frontend/nixpacks.toml` for build configuration

## Railway Setup Steps

1. **Create Backend Service**:
   - Click "New Service" → "GitHub Repo"
   - Select your repository
   - **Set Root Directory to**: `backend`
   - Railway will auto-detect Node.js

2. **Create Frontend Service**:
   - Click "New Service" → "GitHub Repo"  
   - Select your repository
   - **Set Root Directory to**: `frontend`
   - Railway will auto-detect Node.js

3. **Add PostgreSQL Database**:
   - Click "New Service" → "Database" → "PostgreSQL"
   - Railway will create the database automatically

## Why Root Directory is Important

Railway needs to know where to find:
- `package.json` (to detect Node.js)
- `nixpacks.toml` (for custom build configuration)
- Source code files

Without setting the root directory, Railway looks at the repository root and gets confused by the monorepo structure.

## Alternative: Using Docker

If Railway still has issues with Nixpacks, you can use Docker instead:
- Railway will detect `Dockerfile` in each service directory
- Set Root Directory: `backend` or `frontend`
- Railway will build using Docker instead of Nixpacks

## Troubleshooting

If you see "Railpack could not determine how to build":
1. ✅ Check Root Directory is set correctly (`backend` or `frontend`)
2. ✅ Verify `package.json` exists in that directory
3. ✅ Check `nixpacks.toml` is in the service directory
4. ✅ Try using Docker instead (set Root Directory + Dockerfile exists)


