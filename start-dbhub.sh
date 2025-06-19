#!/bin/bash

# Цвета для вывода
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}   MCP Тестовый стенд dbhub - Запуск  ${NC}"
echo -e "${BLUE}======================================${NC}"

# Проверяем, запущен ли MySQL
echo -e "${YELLOW}Проверка статуса MySQL контейнера...${NC}"
if ! docker compose ps | grep -q "mysql.*Up"; then
    echo -e "${RED}MySQL контейнер не запущен. Запустите его с помощью ./start.sh${NC}"
    exit 1
fi

# Получаем имя сети Docker
NETWORK_NAME=$(docker network ls | grep mcp2_default | awk '{print $2}')
if [ -z "$NETWORK_NAME" ]; then
    echo -e "${RED}Не удалось найти сеть Docker для MySQL. Запустите MySQL с помощью ./start.sh${NC}"
    exit 1
fi

echo -e "${YELLOW}Запуск dbhub для тестирования подключения...${NC}"
echo -e "${YELLOW}Используется сеть: ${NETWORK_NAME}${NC}"

# Запускаем dbhub с правильными параметрами
echo -e "${YELLOW}Тестирование подключения к MySQL...${NC}"
docker run --rm --network ${NETWORK_NAME} bytebase/dbhub --dsn "mysql://demo:password@mysql:3306/demo" --test-connection

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Подключение к MySQL успешно!${NC}"
    echo -e "${BLUE}======================================${NC}"
    echo -e "${GREEN}Для использования dbhub в Windsurf/PhpStorm, добавьте следующую конфигурацию в ~/.codeium/mcp_config.json:${NC}"
    echo -e "${YELLOW}"
    echo '{
  "dbhub-mysql-test": {
    "command": "docker",
    "args": [
      "run",
      "-i",
      "--rm",
      "--network",
      "'${NETWORK_NAME}'",
      "bytebase/dbhub",
      "--transport",
      "stdio",
      "--dsn",
      "mysql://demo:password@mysql:3306/demo"
    ],
    "transportType": "stdio",
    "autoApprove": [],
    "disabled": false,
    "timeout": 60
  }
}'
    echo -e "${NC}"
else
    echo -e "${RED}Не удалось подключиться к MySQL.${NC}"
    echo -e "${YELLOW}Попробуйте альтернативную конфигурацию с использованием host сети:${NC}"
    echo -e "${YELLOW}"
    echo '{
  "dbhub-mysql-test": {
    "command": "docker",
    "args": [
      "run",
      "-i",
      "--rm",
      "--network",
      "host",
      "bytebase/dbhub",
      "--transport",
      "stdio",
      "--dsn",
      "mysql://demo:password@localhost:3307/demo"
    ],
    "transportType": "stdio",
    "autoApprove": [],
    "disabled": false,
    "timeout": 60
  }
}'
    echo -e "${NC}"
fi

echo -e "${BLUE}======================================${NC}"
