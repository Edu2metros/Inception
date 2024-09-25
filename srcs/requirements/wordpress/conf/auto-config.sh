#!/bin/bash

if [ -f /var/www/wordpress/wp-config-sample.php ]; then
    rm -rf /var/www/wordpress/wp-config-sample.php

    if ! wp core is-installed --allow-root --path=/var/www/wordpress; then
        wp core install --allow-root \
            --path=/var/www/wordpress \
            --title="Inception" \
            --url="eddos-sa.42.fr" \
            --admin_user="$WP_ROOT_USER" \
            --admin_password="$WP_ROOT_PASSWORD" \
            --admin_email="$WP_ROOT_EMAIL"
    fi

    if ! wp user get "$WP_USER" --allow-root --path=/var/www/wordpress > /dev/null 2>&1; then
        wp user create --allow-root \
            --path=/var/www/wordpress \
            "$WP_USER" "$WP_EMAIL" \
            --user_pass="$WP_PASSWORD" \
            --role='author'
    fi
fi

exec php-fpm -F
