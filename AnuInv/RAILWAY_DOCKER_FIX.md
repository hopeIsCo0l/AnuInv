# Fix: Use Docker Instead of Nixpacks

## Problem
Railway is seeing the entire repo structure instead of just `backend/` directory. This happens because the root directory isn't set correctly in Railway UI, and Nixpacks can't determine the build context.

## Solution: Use Docker
Since we have Dockerfiles in the correct directories, Railway will automatically:
- Detect the Dockerfile in `backend/` directory
- Use it as the build context
- Build from the correct directory

## Changes Made

### backend/railway.json
Changed from NIXPACKS to DOCKERFILE:
```json
{
  "build": {
    "builder": "DOCKERFILE",
    "dockerfilePath": "Dockerfile"
  }
}
```

## Why This Works

1. **Dockerfile is in backend/** - Railway will use it automatically
2. **No root directory needed** - Dockerfile defines its own context
3. **Already tested** - Dockerfile works locally with docker-compose

## Next Steps

1. **Deploy using Docker**:
   ```powershell
   cd backend
   railway up
   ```

2. **Railway will**:
   - Detect Dockerfile in backend/
   - Build using Docker
   - Deploy the container

## Alternative: Set Root Directory in Railway UI

If you prefer Nixpacks:
1. Go to Railway Dashboard
2. Open `backend-api` service
3. Settings → Root Directory
4. Set to: `backend`
5. Save and redeploy

But Docker is easier and already configured! ✅

