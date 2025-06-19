# Тестовый стенд для MCP серверов

Этот проект содержит тестовые стенды для демонстрации MCP серверов в PhpStorm/Windsurf.

## Структура проекта

- `docker/` - Докер-конфигурации для различных тестовых стендов
  - `mysql/` - Тестовый стенд MySQL с демонстрационной базой данных
  - `filesystem-demo/` - Тестовый стенд для работы с файловой системой

## Запуск тестовых стендов

Для запуска тестовых стендов используйте:

```bash
docker-compose up -d
```

## Доступные сервисы

1. **MySQL**
   - Порт: 3306
   - База данных: demo
   - Пользователь: demo
   - Пароль: password

2. **Файловая система**
   - Порт: 8000 (для веб-доступа)
   - Директория: /projects

## Использование с MCP в PhpStorm/Windsurf

Для настройки MCP серверов в Windsurf, добавьте следующие конфигурации в файл конфигурации MCP:

```json
{
  "servers": [
    {
      "name": "filesystem",
      "command": ["path/to/mcp-filesystem", "--allowed-dirs=/projects"]
    },
    {
      "name": "dbhub",
      "command": ["path/to/mcp-dbhub", "--dsn=mysql://demo:password@localhost:3306/demo"]
    }
  ]
}
```
