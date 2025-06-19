# Тестовые стенды MCP серверов

Этот проект содержит тестовые стенды для демонстрации работы MCP серверов в PhpStorm с Windsurf.

## Структура проекта

```
.
├── docker/
│   └── mysql/            # Dockerfile для MySQL с демо-данными
├── demo_files/           # Демонстрационные файлы для MCP filesystem
│   ├── docs/             # Документация
│   ├── src/              # Исходный код
│   └── public/           # Публичные файлы
└── docker-compose.yml    # Конфигурация для запуска контейнеров
```

## Запуск тестового стенда MySQL

### Предварительные требования

- Docker
- Docker Compose
- PhpStorm с плагином Windsurf

### Сборка и запуск контейнера

```bash
# Сборка и запуск контейнера
./start.sh

# Проверка статуса контейнера
docker compose ps
```

## Демонстрация MCP в PhpStorm/Windsurf

Этот тестовый стенд предназначен для демонстрации работы MCP серверов через PhpStorm с плагином Windsurf. 

### Доступные сервисы и ресурсы

1. **MySQL (Docker контейнер)**
   - Порт: 3307
   - База данных: demo
   - Пользователь: demo
   - Пароль: password
   
   Содержит демонстрационные данные с таблицами:
   - employees (сотрудники)
   - projects (проекты)
   - employee_projects (связь многие-ко-многим)
   - departments (отделы)
   - clients (клиенты)

2. **Файловая система (локальный доступ)**
   - Директория с демо-файлами: `/home/smg25/projects/resolventa/mcp2/demo_files`
   - Содержит примеры различных типов файлов для демонстрации возможностей MCP filesystem

## Настройка MCP конфигурации для использования с Windsurf

Для использования MCP серверов с Windsurf, необходимо добавить следующие настройки в файл `~/.codeium/mcp_config.json` или настроить соответствующие параметры в PhpStorm:

```json
{
  "servers": [
    {
      "name": "filesystem",
      "command": ["путь/к/mcp-filesystem", "--allowed-dirs=/home/smg25/projects/resolventa/mcp2/demo_files"]
    },
    {
      "name": "dbhub",
      "command": ["путь/к/mcp-dbhub", "--dsn=mysql://demo:password@localhost:3307/demo"]
    }
  ]
}
```

## Дополнительная информация

### MCP filesystem API

- `mcp2_list_allowed_directories` - Получение списка разрешенных директорий
- `mcp2_list_directory` - Получение списка файлов и директорий
- `mcp2_read_file` - Чтение содержимого файла
- `mcp2_write_file` - Запись содержимого в файл
- `mcp2_create_directory` - Создание директории
- `mcp2_search_files` - Поиск файлов по шаблону
- `mcp2_get_file_info` - Получение информации о файле
- `mcp2_directory_tree` - Получение дерева директорий
- `mcp2_edit_file` - Редактирование файла с построчными изменениями
- `mcp2_move_file` - Перемещение или переименование файла
- `mcp2_read_multiple_files` - Чтение нескольких файлов одновременно

### MCP dbhub API

- Выполнение SQL запросов к MySQL базе данных
- Получение метаданных о таблицах и схемах
- Работа с данными через стандартные SQL операции
