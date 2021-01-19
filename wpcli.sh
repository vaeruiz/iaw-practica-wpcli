#!/bin/bash

# Variables
CLAVE_MYSQL=root
ROOT_MYSQL=root
DB_NAME=wordpress_data
DB_USER=wordpress_user
DB_PASSWORD=wordpress_password
IP_PRIVADA=localhost

# Variables de sitio Wordpress
WP_URL=ip_publica
WP_ADMIN=wp_admin
WP_ADMIN_PASS=wp_admin_password
WP_NAME=sitio_wordpress
WP_ADMIN_EMAIL=adminmail@blackhole.lol

# Activar la depuración del script
set -x

# Actualizar lista de paquetes Ubuntu
apt update -y

# Actualizar el sistema
#apt upgrade -y

# Instalar pila lamp
apt install apache2 -y
apt install mysql-server -y
apt install php libapache2-mod-php php-mysql -y

# Configurar root mysql
mysql -u root -proot <<< "ALTER USER '$ROOT_MYSQL'@'localhost' IDENTIFIED WITH caching_sha2_password BY '$CLAVE_MYSQL';"
mysql -u root -proot <<< "FLUSH PRIVILEGES;"

# Descargar archivo wp-cli.phar
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Asignar permiso de ejecución
chmod +x wp-cli.phar

# Mover el archivo al directorio y cambiar su nombre (así se puede usar sin tener que utilizar una ruta absoluta)
mv wp-cli.phar /usr/local/bin/wp

# Ir al directorio de descarga para Wordpress
cd /var/www/html

# Descargar código de Wordpress (en español) con el flag --allow-root para que permita descargarlo
wp core download --locale=es_ES --allow-root

# Crear base de datos para Wordpress
mysql -u $ROOT_MYSQL -p$CLAVE_MYSQL <<< "DROP DATABASE IF EXISTS $DB_NAME;"
mysql -u $ROOT_MYSQL -p$CLAVE_MYSQL <<< "CREATE DATABASE $DB_NAME;"

# Crear usuario para la base de datos de Wordpress
mysql -u $ROOT_MYSQL -p$CLAVE_MYSQL <<< "DROP USER IF EXISTS '$DB_USER'@'$IP_PRIVADA';"
mysql -u $ROOT_MYSQL -p$CLAVE_MYSQL <<< "CREATE USER '$DB_USER'@'$IP_PRIVADA' IDENTIFIED WITH caching_sha2_password BY '$DB_PASSWORD';"
mysql -u $ROOT_MYSQL -p$CLAVE_MYSQL <<< "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'$IP_PRIVADA';"
mysql -u $ROOT_MYSQL -p$CLAVE_MYSQL <<< "FLUSH PRIVILEGES;"

# Crear archivo de configuración
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --allow-root

# Crear sitio Wordpress
wp core install --url=$WP_URL --title="$WP_NAME" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --allow-root
