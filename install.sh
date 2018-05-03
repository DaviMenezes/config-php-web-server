#!/usr/bin/env bash


if [ "$(id -u)" != "0" ]; then
	echo "Permissão Negada. Rode este script como root."
	exit 1
fi

sudo apt install libnotify-bin

echo Instalando Apache ...
notify-send "Instalando Apache ..." -i face-glasses

apt-get install apache2 php7.0 libapache2-mod-php7.0
apt-get install php7.0-soap php7.0-xml php7.0-curl php7.0-opcache php7.0-gd php7.0-sqlite3 php7.0-mcrypt php7.0-mbstring 
apt-get install rpl zip unzip git vim curl

echo Habilitando modulos do apache ...
notify-send "Habilitando modulos do apache ..." -i face-glasses

a2dismod mpm_event
a2dismod mpm_worker 
a2enmod mpm_prefork 
a2enmod rewrite 
a2enmod php7.0

echo Configurando php ...
notify-send "Configurando php ..." -i face-glasses

echo "" >> /etc/php/7.0/apache2/php.ini
echo "error_log = /tmp/php_errors.log" >> /etc/php/7.0/apache2/php.ini 
echo "display_errors = On" >> /etc/php/7.0/apache2/php.ini 
echo "memory_limit = 256M" >> /etc/php/7.0/apache2/php.ini 
echo "max_execution_time = 120" >> /etc/php/7.0/apache2/php.ini 
echo "error_reporting = E_ALL" >> /etc/php/7.0/apache2/php.ini 
echo "file_uploads = On" >> /etc/php/7.0/apache2/php.ini 
echo "post_max_size = 100M" >> /etc/php/7.0/apache2/php.ini 
echo "upload_max_filesize = 100M" >> /etc/php/7.0/apache2/php.ini 
echo "session.gc_maxlifetime = 14000" >> /etc/php/7.0/apache2/php.ini

echo Reiniciando Apache ...
notify-send "Reiniciando Apache ..." -i face-glasses

service apache2 restart

echo Instalando banco de dados ...
notify-send "Instalando banco de dados ..." -i face-glasses

apt-get install postgresql php7.0-pgsql php7.0-mysql

apt-get update
apt-get install mysql-server


echo Habilitando leitura de .htaccess ...
notify-send "Habilitando leitura de .htaccess ..." -i face-glasses

rpl "AllowOverride None" "AllowOverride All" /etc/apache2/apache2.conf

echo Reiniciando Apache ...
notify-send "Reiniciando Apache ..." -i face-glasses

service apache2 restart

echo A instalação terminou ...
notify-send "A instalação terminou ..." -i face-glasses
