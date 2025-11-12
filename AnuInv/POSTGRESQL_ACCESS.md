# PostgreSQL (psql) Installation Status

## Current Status

❌ **psql is NOT installed locally** on your Windows system.

However, you have PostgreSQL running in Docker:
- Container: `anuinv-postgres`
- Port mapping: `5433:5432`
- Database: `anuinv_db`

## Options to Access PostgreSQL

### Option 1: Use psql from Docker Container ⭐ (Recommended)

When Docker Desktop is running, you can access psql through the container:

```bash
# Connect to database
docker exec -it anuinv-postgres psql -U postgres -d anuinv_db

# Or connect to PostgreSQL server
docker exec -it anuinv-postgres psql -U postgres
```

**Common psql commands:**
```sql
-- List all databases
\l

-- Connect to database
\c anuinv_db

-- List all tables
\dt

-- Describe a table
\d users

-- Run SQL query
SELECT * FROM users;

-- Exit psql
\q
```

### Option 2: Install PostgreSQL Locally

If you want psql installed on your Windows system:

1. **Download PostgreSQL:**
   - Visit: https://www.postgresql.org/download/windows/
   - Download the installer
   - Run the installer and follow the setup wizard

2. **During installation:**
   - Choose a port (default is 5432, but you're using 5433 for Docker)
   - Set a password for the `postgres` user
   - Add PostgreSQL to PATH (recommended)

3. **After installation:**
   ```bash
   psql --version
   psql -U postgres -h localhost -p 5433 -d anuinv_db
   ```

### Option 3: Use Prisma Studio (GUI) ⭐ (Easiest)

Prisma Studio provides a visual interface to browse and edit your database:

```bash
cd backend
npm run prisma:studio
```

This will open a web interface at `http://localhost:5555` where you can:
- Browse all tables
- View and edit data
- Run queries visually

## Recommendation

For your current setup, **Option 1 (Docker)** or **Option 3 (Prisma Studio)** are the easiest options since you already have PostgreSQL running in Docker. You don't need to install PostgreSQL locally unless you specifically need psql commands outside of Docker.

## Quick Access Commands

```bash
# Connect via Docker
docker exec -it anuinv-postgres psql -U postgres -d anuinv_db

# Or use Prisma Studio
cd backend
npm run prisma:studio
```

