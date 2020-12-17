#!/bin/bash
#kanoume update ta packeta
sudo apt update && sudo apt upgrade -y

#bazome to apache to maria db kai to php
sudo apt install apache2 php php-cli php-mysql libapache2-mod-php php-mbstring openssh-server net-tools unzip avahi-daemon -y
sudo apt-get install -qq mariadb-server


#mizaroume to apache gia to boot
sudo systemctl enable apache2
sudo systemctl enable mariadb
sudo systemctl start mariadb

#kanoume restart ton apache coz why not
sudo systemctl restart apache2

#ftiaxnoume to firewall gia ton apache
sudo ufw allow in "Apache Full"
sudo ufw allow ssh 
#dinome dikaiomata gia ton idioktiti
sudo chmod -R 0755 /var/www/html/
sudo echo "<?php phpinfo(); ?>" > /var/www/html/info.php

#Nextcloud download
sudo wget -c https://download.nextcloud.com/server/releases/nextcloud-18.0.0.zip

#Nextcloud folder installation  
sudo unzip nextcloud-18.0.0.zip
sudo cp -r nextcloud /var/www/html/
sudo chown -R www-data:www-data /var/www/html/nextcloud

#Configuring apache to nexcloud
  
sudo echo "Alias /nextcloud "/var/www/html/nextcloud/"

<Directory /var/www/html/nextcloud/>
  Require all granted
  Options FollowSymlinks MultiViews
  AllowOverride All

 <IfModule mod_dav.c>
  Dav off
 </IfModule>

 SetEnv HOME /var/www//html/nextcloud
 SetEnv HTTP_HOME /var/www/html/nextcloud
</Directory>" >> /etc/apache2/sites-available/nextcloud.conf

#Enable Apache modules
sudo a2ensite nextcloud.conf
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod env
sudo a2enmod dir
sudo a2enmod mime

#hope it works
sudo systemctl restart apache2