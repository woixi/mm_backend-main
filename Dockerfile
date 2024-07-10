# Используем базовый образ Python 3.12 slim на основе Debian Bullseye
FROM python:3.12-slim-bullseye

# Определяем переменные окружения для Python
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Обновляем и устанавливаем необходимые зависимости
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        libpython3-dev \
        libpq-dev \
        gcc \
        gettext && \
    rm -rf /var/lib/apt/lists/*

# Обновляем pip до последней версии
RUN pip install --upgrade pip

# Устанавливаем рабочую директорию внутри контейнера
ENV APP_HOME_DIR /mm
ENV PYTHONPATH $APP_HOME_DIR/src
WORKDIR $APP_HOME_DIR

# Создаем необходимые директории
RUN mkdir -p $APP_HOME_DIR/logs
RUN mkdir -p $APP_HOME_DIR/src/media/attachments

# Копируем файл requirements.txt и устанавливаем зависимости
COPY ./requirements.txt $APP_HOME_DIR/requirements.txt
RUN pip install -r $APP_HOME_DIR/requirements.txt

# Указываем порт, который будем экспонировать
EXPOSE 8000

# Определяем переменную окружения для дисплея, чтобы избежать сбоев
ENV DISPLAY=:99

# Запуск Gunicorn для ASGI-приложения
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "4", "settings.asgi:application"]
