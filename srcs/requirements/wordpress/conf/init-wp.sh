#!/bin/bash 

# Check database connectivity before proceeding
until mysql -h $DB_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" > /dev/null 2>&1; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

# Update PHP-FPM config
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /run/php

# Create WordPress directory and set permissions 
mkdir -p /var/www/html
chmod 755 /var/www/html
chown -R www-data:www-data /var/www/html
cd /var/www/html

# download WordPress
wp core download --allow-root

#Create wp-config
wp config create --allow-root \
    --dbname=$MYSQL_DB \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost=$DB_HOST:3306

# Install WordPress
wp core install --allow-root \
    --url=$DOMAIN_NAME \
    --title=$WP_TITLE \
    --admin_user=$WP_ADMIN_N \
    --admin_password=$WP_ADMIN_P \
    --admin_email=$WP_ADMIN_E

# Create WordPress user
wp user create --allow-root \
    $WP_U_NAME $WP_U_EMAIL \
    --user_pass=$WP_U_PASS \
    --role=$WP_U_ROLE

# Start PHP-FPM
exec php-fpm7.4 -F
