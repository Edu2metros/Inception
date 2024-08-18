FROM debian:oldstable

RUN apt update && apt upgrade -y && \
    apt install -y nginx openssl curl && \
    mkdir -p /etc/nginx/ssl /var/run/nginx /var/www/wordpress && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=BR/ST=SP/L=Sp/O=42sp/CN=eddos-sa.42.fr" && \
    chown -R www-data:www-data /var/www/wordpress && \
    chmod -R 755 /var/www/wordpress

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
