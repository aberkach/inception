#!/bin/bash 

# Check database connectivity before proceeding
until mysql -h $DB_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD &> /dev/null
do
    sleep 5
done
# Update PHP-FPM config
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /run/php


# Create WordPress directory and set permissions 
mkdir -p /var/www/html
chmod 755 /var/www/html
chown -R www-data:www-data /var/www/html
cd /var/www/html

# download WordPress if it is not already installed
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Downloading WordPress"
    wp core download --allow-root
fi
# create wp-config.php if it does not exist
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating wp-config.php"
    wp config create --allow-root \
        --dbname=$MYSQL_DB \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=$DB_HOST:3306 \
        --skip-check
fi


# Install WordPress if it is not already installed
if ! wp core is-installed --allow-root; then
    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_N \
        --admin_password=$WP_ADMIN_P \
        --admin_email=$WP_ADMIN_E \
        --skip-email
fi

# create a new user for WordPress if it does not exist
if ! wp user list --allow-root --field=user_login | grep -q $WP_U_NAME; then
    wp user create --allow-root $WP_U_NAME $WP_U_EMAIL --user_pass=$WP_U_PASS --role=$WP_U_ROLE 
fi


# Start PHP-FPM
exec php-fpm7.4 -F

