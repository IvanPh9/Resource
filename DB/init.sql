-- Схема бази даних для сервісу автентифікації

-- Таблиця користувачів
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблиця збережених refresh-токенів (для контролю сесій)
CREATE TABLE IF NOT EXISTS refresh_sessions (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    token_hash VARCHAR(64) NOT NULL, -- SHA-256 від токена, сам токен у БД не зберігаємо
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
