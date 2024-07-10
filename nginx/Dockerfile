# Используем базовый образ nginx
FROM nginx:1.27-alpine

# Удаляем стандартную конфигурацию Nginx
RUN rm /etc/nginx/conf.d/default.conf

# Копируем нашу конфигурацию Nginx
COPY ./default.conf /etc/nginx/conf.d/default.conf

# Определяем точку входа
CMD ["nginx", "-g", "daemon off;"]
