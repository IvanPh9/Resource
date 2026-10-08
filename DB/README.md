# PostgreSQL Database Container

Containerized PostgreSQL database for the authentication service (`platform_auth`).

## Directory Structure

- `docker-compose.yml` - Docker Compose configuration for launching the PostgreSQL container.
- `init.sh` - Shell script for initializing database tables, ENUM types, DBMS roles, and privileges.
- `.env` - Local environment variables configuration.
- `.env.example` - Example template for `.env`.

## PostgreSQL Database Accounts

1. `postgres` (Superuser / Owner)
   - Password: Loaded from system environment variable `POSTGRES_PASSWORD`.
   - Used for database initialization and full administration.
2. `app_user` (Standard Application Account)
   - Password: Defined in `.env` (`DB_APP_USER_PASSWORD`).
   - Permissions: `SELECT`, `INSERT`, `UPDATE`, `DELETE` on tables and `USAGE` on sequences.
3. `app_admin` (Application Admin / Migration Account)
   - Password: Loaded from system environment variable `DB_APP_ADMIN_PASSWORD`.
   - Permissions: `ALL PRIVILEGES` within schema `public`.

## Roles in users Table

The `users` table uses the `user_role` ENUM type:
- `'user'` - Standard user (default).
- `'admin'` - Administrator.

## Database Connection Parameters

- Host: `localhost` (or `127.0.0.1`)
- External Port: `5433`
- Database: `auth_db`

## Running the Database

To start the database in detached mode:

```bash
docker compose up -d
```
