# Resource Platform

## Project Overview

This repository represents the foundation for a multi-project platform architecture. The goal is to build a centralized infrastructure that will serve multiple interconnected services and applications.

Current Phase: Prototyping Version.

Development began with the core foundation:
- Centralized Authentication Platform (`platform_auth`) - manages user registration, login, and role-based access control.
- Database Infrastructure (`DB`) - PostgreSQL database running in Docker Compose with role separation and initialization scripts.

## Running the Project

To build and start all project services:

```bash
docker compose up -d --build
```

After startup, the following services will be available:
- PostgreSQL Database (`db`): available at `127.0.0.1:5433`
- Authentication Microservice (`platform_auth`): available at `http://localhost:3001`

## Project Structure

- `platform_auth/` - Authentication microservice (Express.js, ES Modules, AuthController).
- `DB/` - PostgreSQL configuration, initialization scripts, and DBMS role definitions.
- `docker-compose.yml` - Root orchestration file for starting the entire platform ecosystem.

## Useful Commands

View status of all containers:
```bash
docker compose ps
```

View logs for all services:
```bash
docker compose logs -f
```

View logs for the authentication service:
```bash
docker compose logs -f platform_auth
```

Stop all services:
```bash
docker compose down
```

Stop services and remove database volumes:
```bash
docker compose down -v
```
