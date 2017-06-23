#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y nginx

# Install php-fpm
sudo apt-get -f install
sudo sh -c 'echo "Nerdear.la!" > /var/www/html/index.nginx-debian.html'
# Restart servers
sudo service nginx restart
