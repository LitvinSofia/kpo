#!/bin/bash
cp .env ./app/.env
# Билд основного приложения
docker build -t book-bot-app ./app

# Билд тестов
docker build -t book-bot-units ./units

docker build -t book-bot-integration ./integration

docker rm -f book-bot-db
# Запуск БД
docker run -d --name book-bot-db \
  -e POSTGRES_USER=user \
  -e POSTGRES_PASSWORD=pass \
  -e POSTGRES_DB=books \
  -p 5434:5432 \
  -v postgres_data:/var/lib/postgresql/data \
  postgres:15

echo "Все образы собраны и БД запущена"
