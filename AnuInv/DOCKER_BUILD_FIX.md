# Docker Build Fix Guide

## Issue
The Docker build was failing because Next.js 16 requires Node.js 20+, but the cached Docker images were using Node.js 18.

## Solution

### Option 1: Rebuild Without Cache (Recommended)

```bash
# Rebuild all services without cache
docker-compose build --no-cache

# Or rebuild specific services
docker-compose build --no-cache frontend
docker-compose build --no-cache backend

# Then start the services
docker-compose up
```

### Option 2: Remove All Docker Images and Rebuild

```bash
# Stop all running containers
docker-compose down

# Remove all images
docker rmi anuinv-frontend anuinv-backend

# Rebuild
docker-compose build

# Start services
docker-compose up
```

### Option 3: Clean Docker System (Nuclear Option)

```bash
# Remove all unused Docker resources
docker system prune -a

# Rebuild
docker-compose build

# Start services
docker-compose up
```

## What Was Fixed

1. ✅ Updated Dockerfiles to use Node.js 20
2. ✅ Removed `version` from docker-compose.yml (obsolete)
3. ✅ Updated Nixpacks configuration for Node.js 20
4. ✅ Fixed frontend start command to use PORT environment variable

## Verify the Fix

After rebuilding, check that:
- Frontend builds successfully
- Backend builds successfully
- All services start without errors
- Frontend is accessible on http://localhost:3001
- Backend is accessible on http://localhost:3000

## Troubleshooting

### If build still fails:

1. **Check Node.js version in Dockerfile**:
   ```bash
   grep "FROM node" frontend/Dockerfile backend/Dockerfile
   ```
   Should show `node:20-alpine`

2. **Clear Docker build cache**:
   ```bash
   docker builder prune -a
   ```

3. **Check Next.js version**:
   ```bash
   grep "next" frontend/package.json
   ```
   Next.js 16 requires Node.js 20+

4. **Verify Docker is running**:
   ```bash
   docker --version
   docker-compose --version
   ```

## Next Steps

Once the build succeeds:
1. Test the application locally
2. Push changes to GitHub
3. Deploy to Railway (will use Node.js 20 automatically)

## Notes

- Railway will automatically use Node.js 20 based on the nixpacks.toml configuration
- The Dockerfiles are now consistent with Railway's requirements
- All services use Node.js 20 for consistency

