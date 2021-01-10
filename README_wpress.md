# Práctica IAW 8

Vamos a montar una máquina servidora en la que insatalaremos wordpress

## Creando la máquina

Hacemos una máquina Ubuntu server con los puertos HTTP (80) HTTPS (443) y el puerto MySQL (3306) con los campos de subred 0.0.0.0/0, ::/0.

## Configurando la máquina

Cuando hayamos creado la máquina y esté en funcionamiento nos conectamos a ella a través de ssh o a través de Visual Studio Code.

Clonamos el repositorio de github de la práctica

>git clone https://github.com/vaeruiz/iaw-practica-07.git

Cuando se haya descargado el directorio movemos el script de instalación al directorio de ubuntu:

>mv iaw-practica-07/balanceador.sh /home/ubuntu/

Le añadimos permiso de ejecución:

>sudo chmod +x balanceador.sh

Y ejecutamos el script

>sudo ./balanceador.sh