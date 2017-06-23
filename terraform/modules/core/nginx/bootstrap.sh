#!/usr/bin/env bash

apt-get update
mkdir -p /var/www
# Install nginx
apt-get install -y nginx

# Install php-fpm
apt-get install -y php5-cli php5-common php5-mysql php5-gd php5-fpm php5-fpm php-pear 
apt-get -f install

# Stop servers
service nginx stop
service php5-fpm stop

sed -i.bak 's/^;cgi.fix_pathinfo.*$/cgi.fix_pathinfo = 0/g' /etc/php5/fpm/php.ini

# www.conf
sed -i.bak 's/^;security.limit_extensions.*$/security.limit_extensions = .php .php3 .php4 .php5/g' /etc/php5/fpm/pool.d/www.conf
sed -i.bak 's/^;listen\s.*$/listen = \/var\/run\/php5-fpm.sock/g' /etc/php5/fpm/pool.d/www.conf
sed -i.bak 's/^listen.owner.*$/listen.owner = www-data/g' /etc/php5/fpm/pool.d/www.conf
sed -i.bak 's/^listen.group.*$/listen.group = www-data/g' /etc/php5/fpm/pool.d/www.conf
sed -i.bak 's/^;listen.mode.*$/listen.mode = 0660/g' /etc/php5/fpm/pool.d/www.conf

service php5-fpm restart

ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Configure host
cat << 'EOF' > /etc/nginx/sites-available/default
server
{
    listen  80;
    root /var/www;
    index index.php index.html index.htm;
#    server_name localhost
    location "/"
    {
        index index.php index.html index.htm;
        try_files $uri $uri/ =404;
    }

    location ~ \.php$
    {
        include /etc/nginx/fastcgi_params;
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME /vagrant$fastcgi_script_name;
    }
}
EOF

# Restart servers
service nginx restart
service php5-fpm restart
