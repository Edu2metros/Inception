#!/bin/bash
set -e
set -x

service mariadb start

# Esperar até que o MySQL esteja pronto para aceitar conexões
until mysql -u root -p$MYSQL_ROOT_PASSWORD -e "SHOW DATABASES;" > /dev/null 2>&1; do
  echo "Aguardando MySQL iniciar..."
  sleep 5
done

echo "MySQL iniciado."

# Criar o banco de dados se não existir
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
# Criar o usuário se não existir
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
# Conceder permissões ao usuário
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
# Alterar a senha do usuário root
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
# Aplicar as mudanças de permissões
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
# Encerrar o MySQL
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
# Iniciar o MySQL em modo seguro
exec mysqld_safe