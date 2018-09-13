FROM php:7.2-rc-apache

MAINTAINER Joe Nyugoh <joenyugoh@gmail.com>

RUN apt update -y && \
    apt install -y gnupg gnupg2 gnupg1 && \
    docker-php-ext-install mysqli pdo pdo_mysql && \
    apt update && apt install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

WORKDIR /var/www/html

COPY ./* /var/www/html/

RUN chown www-data:www-data -R /var/www/html/*


EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
