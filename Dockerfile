FROM debian:10
RUN mkdir -p /var/www/html
WORKDIR /var/www/html
COPY ./src/ /var/www/html/
RUN chown -R www-data:www-data /var/www/html
RUN apt-get update -y
RUN apt-get install php7.3 php7.3-zip php7.3-xml php7.3-mysql -y
CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]

