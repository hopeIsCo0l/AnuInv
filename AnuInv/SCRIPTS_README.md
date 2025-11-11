# Shell Scripts Overview

## Created Shell Scripts

### Docker Entrypoint Scripts

1. **`backend/docker-entrypoint.sh`**
   - Handles database connection waiting
   - Runs Prisma migrations
   - Starts the NestJS application
   - Used as Docker entrypoint

2. **`frontend/docker-entrypoint.sh`**
   - Starts Next.js production server
   - Handles PORT environment variable
   - Used as Docker entrypoint

### Utility Scripts

3. **`scripts/init-db.sh`**
   - Database initialization script
   - Waits for PostgreSQL to be ready
   - Can be extended for data seeding

4. **`scripts/start-dev.sh`**
   - Development startup script
   - Checks Docker status
   - Starts all services

5. **`scripts/build.sh`**
   - Production build script
   - Builds both backend and frontend images
   - Useful for CI/CD

6. **`scripts/cleanup.sh`**
   - Cleanup script
   - Removes containers and volumes
   - Useful for resetting local environment

### Health Check Scripts

7. **`backend/healthcheck.sh`**
   - Health check script for backend
   - Can be used for custom health checks

## Usage

### Make Scripts Executable (Linux/Mac)

```bash
chmod +x backend/docker-entrypoint.sh
chmod +x frontend/docker-entrypoint.sh
chmod +x scripts/*.sh
```

### Windows (Git Bash/WSL)

Scripts work in Git Bash and WSL. For PowerShell, use the `.ps1` scripts.

### Running Scripts

```bash
# Development
./scripts/start-dev.sh

# Build
./scripts/build.sh

# Cleanup
./scripts/cleanup.sh
```

## Docker Integration

The entrypoint scripts are automatically used by Docker:
- Backend: `docker-entrypoint.sh` handles migrations and startup
- Frontend: `docker-entrypoint.sh` starts Next.js server

## Benefits

1. **Better Error Handling**: Scripts use `set -e` to exit on errors
2. **Database Waiting**: Backend waits for database before starting
3. **Cross-Platform**: Works on Linux, Mac, and Windows (via WSL/Git Bash)
4. **Maintainability**: Centralized startup logic
5. **Production Ready**: Proper entrypoint handling for Docker

## Notes

- All scripts use `#!/bin/sh` for maximum compatibility
- Scripts are executable and ready to use
- Entrypoint scripts are integrated into Dockerfiles
- Utility scripts are optional but recommended

