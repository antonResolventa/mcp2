# API Документация

## Основные эндпоинты

### Пользователи

#### GET /api/users

Получение списка всех пользователей.

**Параметры запроса:**
- `page` (integer, опционально) - Номер страницы, по умолчанию 1
- `limit` (integer, опционально) - Количество пользователей на странице, по умолчанию 10
- `sort` (string, опционально) - Поле для сортировки, по умолчанию 'id'
- `order` (string, опционально) - Порядок сортировки ('asc' или 'desc'), по умолчанию 'asc'

**Ответ:**
```json
{
  "data": [
    {
      "id": 1,
      "username": "admin",
      "email": "admin@example.com",
      "role": "admin",
      "created_at": "2023-06-01T10:00:00Z"
    },
    {
      "id": 2,
      "username": "user1",
      "email": "user1@example.com",
      "role": "user",
      "created_at": "2023-06-02T11:30:00Z"
    }
  ],
  "meta": {
    "total": 42,
    "page": 1,
    "limit": 10,
    "pages": 5
  }
}
```

#### GET /api/users/{id}

Получение информации о конкретном пользователе по ID.

**Параметры пути:**
- `id` (integer, обязательно) - ID пользователя

**Ответ:**
```json
{
  "id": 1,
  "username": "admin",
  "email": "admin@example.com",
  "role": "admin",
  "created_at": "2023-06-01T10:00:00Z",
  "last_login": "2023-06-15T08:45:30Z",
  "profile": {
    "full_name": "Администратор Системы",
    "avatar": "https://example.com/avatars/admin.jpg",
    "bio": "Главный администратор системы"
  }
}
```

#### POST /api/users

Создание нового пользователя.

**Тело запроса:**
```json
{
  "username": "new_user",
  "email": "new_user@example.com",
  "password": "secure_password",
  "role": "user"
}
```

**Ответ:**
```json
{
  "id": 43,
  "username": "new_user",
  "email": "new_user@example.com",
  "role": "user",
  "created_at": "2023-06-19T14:25:00Z"
}
```

### Аутентификация

#### POST /api/auth/login

Вход в систему.

**Тело запроса:**
```json
{
  "email": "admin@example.com",
  "password": "admin_password"
}
```

**Ответ:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expires_at": "2023-06-20T14:30:00Z",
  "user": {
    "id": 1,
    "username": "admin",
    "email": "admin@example.com",
    "role": "admin"
  }
}
```
