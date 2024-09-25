FROM debian:oldstable

RUN apt-get update && apt-get install -y \
    wget \
    lsb-release \
    ca-certificates \
    apt-transport-https \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
    && apt-get update \
    && apt-get install -y \
    php8.0 \
    php8.0-fpm \
    php8.0-mysql \
    mariadb-client \
    vim \
    && wget https://wordpress.org/latest.tar.gz -P /var/www \
    && tar -xvf /var/www/latest.tar.gz -C /var/www && rm /var/www/latest.tar.gz \
    && chown -R www-data:www-data /var/www/wordpress \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp \
    && mkdir /run/php

COPY conf/www.conf /etc/php/8.0/fpm/pool.d/www.conf
COPY conf/wp-config.php /var/www/wordpress/wp-config.php
COPY conf/auto-config.sh /auto-config.sh

RUN chmod +x /auto-config.sh

ENTRYPOINT ["/auto-config.sh"]
