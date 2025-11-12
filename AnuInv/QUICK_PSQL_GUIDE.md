# Quick PostgreSQL Access Guide

## Connect to Database

Since Docker Desktop is running, use this command:

```bash
docker exec -it anuinv-postgres psql -U postgres -d anuinv_db
```

## Common psql Commands

### Database Navigation
```sql
-- List all tables
\dt

-- Describe a specific table structure
\d users
\d warehouses
\d inventory

-- List all databases
\l

-- Connect to a different database
\c database_name
```

### Querying Data
```sql
-- View all users
SELECT * FROM users;

-- View specific columns
SELECT id, email, fullName, role FROM users;

-- Count records
SELECT COUNT(*) FROM users;

-- Filter data
SELECT * FROM users WHERE role = 'Yer';
```

### Table Management
```sql
-- View table structure
\d+ users

-- List all columns in a table
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'users';
```

### Exit
```sql
-- Exit psql
\q
```

## Quick Examples

### Check if tables exist:
```bash
docker exec -it anuinv-postgres psql -U postgres -d anuinv_db -c "\dt"
```

### View all users:
```bash
docker exec -it anuinv-postgres psql -U postgres -d anuinv_db -c "SELECT * FROM users;"
```

### Count records in a table:
```bash
docker exec -it anuinv-postgres psql -U postgres -d anuinv_db -c "SELECT COUNT(*) FROM users;"
```

## Interactive Mode

For interactive use, connect without the `-c` flag:

```bash
docker exec -it anuinv-postgres psql -U postgres -d anuinv_db
```

Then you can run commands interactively and see results immediately.

