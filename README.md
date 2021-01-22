# WP-CLI

Instalación de la herramienta Wordpress-CLI

## Creando la máquina

Necesitamos una máquina Ubuntu server con los puertos HTTP (80), HTTPS (443), y MySQL (3306) con los campos de subred 0.0.0.0/0, ::/0.

## Configurando la máquina

Lo primero es instalar la pila LAMP, se puede utilizar el script creado anteriormente en la práctica 2.

Con la pila LAMP instalada, descargamos el archivo .phar de wp-cli con el comando

>curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

Asignamos permiso de ejecución al .jhar descargado

>chmod +x wp-cli.phar

Lo siguiente que tenemos que hacer es mover el archivo al directorio /usr/local/bin para poder ejecutar la herramienta sin tener que escribir una ruta absoluta, además, le cambiaremos el nombre para que pueda estar más a mano.

>mv wp-cli.phar /usr/local/bin/wp

Ya hemos instalado wp-cli y podemos hacer uso de l aherramienta.

## Creando una página Wordpress con wp-cli

Teniendo la utilidad instalada, lo primero que debemos hacer es descargar el código fuente de WordPress, esto se puede hacer con el comando:

>wp core download

Necesitamos que el código se descargue en el directorio /var/www/html, lo podemos conseguir moviéndonos a el directorio mediante cd, o añadiendo la ruta al comando wp core download de la siguiente manera:

>wp core download --path=/var/www/html

Podemos elegir en que idioma se descargará el código de Wordpress con el siguiente comando:

>wp core download --locale=es_ES

Al final del comando hay que añadir el flag --allow-root, de tal forma que el comando sea "wp core download (--locale=es_ES) --allow-root" dado que sin el flag se le deniega el acceso a la herramienta.

Con este comando Wordpress se descargará en español.

Ahora crearemos una base de datos en el servidor MySQL para posteriormente ejecutar la utilidad wp-cli y que cree el archivo de configuración.

Ahora ejecutamos el comando para la creación del archivo de configuración:

>wp config create --dbname=(nombre de base de datos de wp) --dbuser=(nombre del usuario de wp) --dbpass=(clave del usuario de wp) --allow-root

Después de esto podemos ejecutar el comando para crear nuestro sitio web con Wordpress, lo hacemos con el comando:

>wp core install --url=(url del servidor o máquina donde se va a crear el sitio) --title=(nombre dle sitio, debe ir con "") --admin_user=(nombre del usuario administrador) --admin_password=(clave del usuario administrador) --admin_email=(email del administrador) --allow-root
