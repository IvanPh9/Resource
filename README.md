# Project Resource Setup

Docker Compose environment for running the entire project setup.

## Running the Project

To build and start all project services (Database and Microservices):

```bash
docker compose up -d --build
```

After startup, the following services will be available:
- PostgreSQL Database (`db`): available at `127.0.0.1:5433`
- Authentication Microservice (`platform_auth`): available at `http://localhost:3001`

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
