#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- 1. Створення ENUM типу для ролей у додатку
    DO \$\$ BEGIN
        CREATE TYPE user_role AS ENUM ('user', 'admin');
    EXCEPTION
        WHEN duplicate_object THEN null;
    END \$\$;

    -- 2. Таблиця користувачів
    CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        email VARCHAR(255) UNIQUE NOT NULL,
        password_hash VARCHAR(255) NOT NULL,
        role user_role NOT NULL DEFAULT 'user',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);

    -- 3. Таблиця збережених сесій
    CREATE TABLE IF NOT EXISTS refresh_sessions (
        id SERIAL PRIMARY KEY,
        user_id INT REFERENCES users(id) ON DELETE CASCADE,
        token_hash VARCHAR(64) NOT NULL,
        expires_at TIMESTAMP NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    -- 4. Створення користувачів СУБД із паролями зі змінних оточення
    DO \$\$ 
    BEGIN
        IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = '${DB_APP_USER}') THEN
            CREATE ROLE ${DB_APP_USER} WITH LOGIN PASSWORD '${DB_APP_USER_PASSWORD}';
        END IF;

        IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = '${DB_APP_ADMIN}') THEN
            CREATE ROLE ${DB_APP_ADMIN} WITH LOGIN PASSWORD '${DB_APP_ADMIN_PASSWORD}';
        END IF;
    END \$\$;

    -- 5. Права доступу для звичайного сервісу (app_user)
    GRANT CONNECT ON DATABASE ${POSTGRES_DB} TO ${DB_APP_USER};
    GRANT USAGE ON SCHEMA public TO ${DB_APP_USER};
    GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO ${DB_APP_USER};
    GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO ${DB_APP_USER};
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO ${DB_APP_USER};
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT ON SEQUENCES TO ${DB_APP_USER};

    -- Права доступу для міграцій / DDL (app_admin)
    GRANT CONNECT ON DATABASE ${POSTGRES_DB} TO ${DB_APP_ADMIN};
    GRANT ALL PRIVILEGES ON SCHEMA public TO ${DB_APP_ADMIN};
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO ${DB_APP_ADMIN};
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO ${DB_APP_ADMIN};
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO ${DB_APP_ADMIN};
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO ${DB_APP_ADMIN};

EOSQL
