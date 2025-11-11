# Docker Runtime Issues - Fixed

## Issues Found

### 1. Frontend: `next: not found`
**Problem**: Next.js wasn't available in the production container
**Solution**: Changed from `npm ci --only=production` to `npm ci` to install all dependencies including Next.js runtime

### 2. Backend: Prisma OpenSSL Error
**Problem**: Prisma requires OpenSSL but Alpine Linux doesn't include it by default
**Solution**: Added `RUN apk add --no-cache openssl1.1-compat` to both builder and production stages

## Changes Made

### Frontend Dockerfile
- Changed `npm ci --only=production` to `npm ci` to ensure Next.js is available

### Backend Dockerfile
- Added OpenSSL installation in builder stage
- Added OpenSSL installation in production stage

## Rebuild Required

After these fixes, rebuild the containers:

```bash
docker-compose down
docker-compose build --no-cache
docker-compose up
```

## Why These Fixes Work

1. **Next.js Runtime**: Next.js needs to be available at runtime, not just build time. Using `npm ci` ensures all dependencies are installed.

2. **Prisma OpenSSL**: Prisma's query engine requires OpenSSL libraries. Alpine Linux uses musl libc which doesn't include OpenSSL by default, so we need to install the compatibility package.

## Testing

After rebuilding, you should see:
- ✅ Frontend starts without "next: not found" error
- ✅ Backend Prisma migrations run successfully
- ✅ No OpenSSL warnings
- ✅ All services running properly

