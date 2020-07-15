FROM php:7-fpm
RUN mkdir -p /var/www/html
WORKDIR /var/www/html
COPY ./src/ /var/www/html/


EXPOSE 9000
