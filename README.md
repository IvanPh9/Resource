# Project Resource — Docker Setup

Загальний Docker-контейнер та середовище для запуску всього проекту ціліком.

## 🚀 Запуск усього проекту

Для запуску всіх сервісів проекту (База даних + Мікросервіси):

```bash
docker compose up -d --build
```

Після запуску будуть підняті сервіси:
- **База даних PostgreSQL (`db`)**: доступна на `localhost:5432`
- **Сервіс автентифікації (`platform_auth`)**: доступний на `http://localhost:3000`

## 🛠 Корисні команди

Переглянути стан усіх контейнерів:
```bash
docker compose ps
```

Переглянути логи всіх сервісів:
```bash
docker compose logs -f
```

Переглянути логи конкретного сервісу:
```bash
docker compose logs -f platform_auth
```

Зупинити всі сервіси:
```bash
docker compose down
```

Зупинити сервіси та видалити дані БД (Volumes):
```bash
docker compose down -v
```
