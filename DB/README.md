# PostgreSQL Database Container

Контейнеризована база даних PostgreSQL для сервісу автентифікації (`platform_auth`).

## 📁 Структура папки DB

- `docker-compose.yml` — конфігурація Docker Compose для підняття контейнера PostgreSQL.
- `init.sql` — скрипт автоматичної ініціалізації таблиць, ENUM ролей, користувачів СУБД та сид-адміна.
- `.env` — файл змінних середовища.
- `.env.example` — приклад шаблону для `.env`.

## 🔐 Користувачі СУБД PostgreSQL

В `init.sql` налаштовано розділення облікових записів СУБД:

1. **`postgres`** (Суперкористувач / Owner)
   - **Password**: зберігається в `.env` файлі (`POSTGRES_PASSWORD`).
   - Використовується для ініціалізації та повного адміністрування бази.
2. **`app_user`** (Звичайний користувач додатка)
   - **Password**: `app_user_password`
   - Права: `SELECT`, `INSERT`, `UPDATE`, `DELETE` на таблиці та `USAGE` на послідовності (Sequences).
3. **`app_admin`** (Адміністратор додатка/міграцій)
   - **Password**: `app_admin_password`
   - Права: `ALL PRIVILEGES` у схемі `public`.

## 👥 Ролі в таблиці `users`

Таблиця `users` використовує ENUM тип `user_role`:
- `'user'` — звичайний користувач сервісу (за замовчуванням).
- `'admin'` — адміністратор сервісу.

### Початковий обліковий запис адміністратора (Seed):
- **Email**: `admin@system.local`
- **Password**: `Admin123!`
- **Role**: `admin`

## 🚀 Запуск бази даних

```bash
docker compose up -d
```
