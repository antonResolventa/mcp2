FROM mysql:8.0

# Аргументы для настройки MySQL
ARG MYSQL_DATABASE=demo
ARG MYSQL_USER=demo
ARG MYSQL_PASSWORD=password
ARG MYSQL_ROOT_PASSWORD=rootpassword

# Устанавливаем переменные окружения
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ENV LANG=C.UTF-8

# Копируем конфигурационный файл MySQL
COPY ./my.cnf /etc/mysql/conf.d/

# Копируем init SQL скрипты
COPY ./init.sql /docker-entrypoint-initdb.d/

# Экспонируем стандартный порт MySQL
EXPOSE 3306
