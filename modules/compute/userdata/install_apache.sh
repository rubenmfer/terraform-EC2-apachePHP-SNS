#!/bin/bash
 
# Actualiza los paquetes e instala Apache
sudo yum update -y
sudo yum install httpd -y
sudo service httpd start
sudo chkconfig httpd on

# Instalar PHP
cd /var/www/html
sudo yum install php  php-cli php-json  php-mbstring -y
sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php
sudo php -r "unlink('composer-setup.php');"
sudo COMPOSER_ALLOW_SUPERSUSER=1 php composer.phar require aws/aws-sdk-php

 
# Inicia Apache y habilita para que inicie en cada reinicio del sistema
sudo systemctl httpd restart
sudo systemctl enable httpd
 

