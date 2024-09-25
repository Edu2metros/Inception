FROM debian:oldstable

ARG SQL_DATABASE
ARG SQL_USER
ARG SQL_PASSWORD
ARG SQL_ROOT_PASSWORD

RUN apt-get update && apt-get install -y mariadb-server curl

COPY ./conf/mariadb.cnf /etc/mysql/mariadb.cnf
COPY ./conf/scriptDB.sh /scriptDB.sh

RUN mkdir -p /var/run/mysqld /run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld /run/mysqld \
    && chmod +x /scriptDB.sh

CMD ["mysqld_safe"]
ENTRYPOINT ["/scriptDB.sh"]
