# Authentication Microservice

Express.js authentication service for the platform.

## Features

- User registration (`POST /api/auth/register`)
- User login (`POST /api/auth/login`)
- Role-based authorization (`user` / `admin`)
- PostgreSQL database integration via connection pool

## Configuration

Environment variables:
- `PORT` - Service port (default: `3000`, exposed on host as `3001`)
- `DB_HOST` - Database host (`db`)
- `DB_PORT` - Database internal port (`5432`)
- `DB_USER` - Database username (`app_user`)
- `DB_PASSWORD` - Database password (`DB_APP_USER_PASSWORD`)
- `DB_NAME` - Database name (`auth_db`)

## Development

Install dependencies:
```bash
npm install
```

Start service locally:
```bash
npm start
```
