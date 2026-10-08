# PostgreSQL Database Container

Контейнеризована база даних PostgreSQL для сервісу автентифікації (`platform_auth`).

## 📁 Структура папки DB

- `docker-compose.yml` — конфігурація Docker Compose для підняття контейнера PostgreSQL.
- `init.sql` — скрипт автоматичної ініціалізації таблиць `users` та `refresh_sessions`.
- `.env` — файл змінних середовища (назва БД, користувач, пароль, порт).
- `.env.example` — приклад шаблону для `.env`.

## 🚀 Запуск бази даних

Для запуску БД у фоновому режимі виконайте команду в директорії `DB`:

```bash
docker compose up -d
```

Перевірити статус контейнера:

```bash
docker compose ps
```

Зупинити базу даних:

```bash
docker compose down
```

Зупинити та видалити збережені дані (очистити Volume):

```bash
docker compose down -v
```

## 🔐 Параметри підключення за замовчуванням

- **Host**: `localhost`
- **Port**: `5432`
- **Database**: `auth_db`
- **User**: `postgres`
- **Password**: `postgres`
- **Connection String**: `postgres://postgres:postgres@localhost:5432/auth_db`

## 📊 Таблиці бази даних

1. `users` — зберігає дані користувачів (`id`, `email`, `password_hash`, `role`, `created_at`).
2. `refresh_sessions` — зберігає сесії refresh-токена (`id`, `user_id`, `token_hash`, `expires_at`, `created_at`).
