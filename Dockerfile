# Docker-команда FROM указывает базовый образ контейнера
# Наш базовый образ - это Linux с предустановленным python-3.9
FROM python:3.9-slim

# Установим переменную окружения
ENV APP_HOME /app

# Установим рабочую директорию внутри контейнера
WORKDIR $APP_HOME

# Установим libtk8.6 и Xvfb
RUN apt-get update && apt-get install -y libtk8.6 x11-apps xvfb

# Настройте переменные окружения для Xvfb
ENV DISPLAY=:99

# Скопируем pyproject.toml, poetry.lock и все остальные файлы в рабочую директорию контейнера
COPY pyproject.toml poetry.lock ./
COPY . .

# Обозначим порт, на котором работает приложение внутри контейнера (если необходимо)
# EXPOSE 5000

# Запустим Xvfb и ваше приложение
CMD Xvfb :99 -ac -screen 0 1024x768x16 & python crutching_botdan/main.py
