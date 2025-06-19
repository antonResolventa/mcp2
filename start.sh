#!/bin/bash

# Цвета для вывода
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}   MCP Тестовый стенд MySQL - Запуск  ${NC}"
echo -e "${BLUE}======================================${NC}"

# Проверяем наличие Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Docker не установлен. Пожалуйста, установите Docker перед запуском.${NC}"
    exit 1
fi

# Проверяем наличие Docker Compose
if ! command -v docker compose &> /dev/null; then
    echo -e "${RED}Docker Compose не установлен. Пожалуйста, установите Docker Compose перед запуском.${NC}"
    exit 1
fi

# Запускаем контейнер MySQL
echo -e "${YELLOW}Запуск MySQL контейнера...${NC}"
docker compose up -d

# Проверяем статус
echo -e "${YELLOW}Проверка статуса контейнера...${NC}"
docker compose ps

# Проверяем доступность MySQL
echo -e "${YELLOW}Проверка доступности MySQL...${NC}"
sleep 5  # Даем немного времени для инициализации MySQL

if docker exec -i $(docker compose ps -q mysql) mysqladmin ping -h localhost -u demo -ppassword --silent 2>/dev/null; then
    echo -e "${GREEN}MySQL доступен. База данных demo готова к использованию.${NC}"
    echo -e "${GREEN}Порт: 3307, Пользователь: demo, Пароль: password${NC}"
else
    echo -e "${RED}Невозможно подключиться к MySQL. Подождите немного, возможно, инициализация еще не завершена.${NC}"
fi

echo -e "${BLUE}======================================${NC}"
echo -e "${GREEN}MCP тестовый стенд MySQL запущен${NC}"
echo -e "${BLUE}======================================${NC}"
echo -e "${YELLOW}Для остановки контейнера выполните:${NC} docker compose down"
echo ""
echo -e "${BLUE}Демонстрационные файлы для MCP filesystem:${NC}"
echo -e "${GREEN}/home/smg25/projects/resolventa/mcp2/demo_files${NC}"
