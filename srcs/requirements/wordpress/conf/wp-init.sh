#!/bin/bash
#---------------------------------------------------wp installation---------------------------------------------------#
# wp-cli installation
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# wp-cli permission
chmod +x wp-cli.phar
# wp-cli move to bin
mv wp-cli.phar /usr/local/bin/wp

# go to wordpress directory
cd /var/www/html/wordpress
# give permission to wordpress directory
chmod -R 755 /var/www/html/wordpress
# change owner of wordpress directory to www-data
chown -R www-data:www-data /var/www/html/wordpress

#---------------------------------------------------ping mariadb---------------------------------------------------#
# check if mariadb container is up and running
ping_mariadb_container() {
    nc -zv mariadb 3306 > /dev/null
    return $? # return exit status of the ping
}

start_time=$(date +%s)
end_time=$((start_time + 30)) # set to 30 seconds

while [ $(date +%s) -lt $end_time ]; do
    ping_mariadb_container
    if [ $? -eq 0 ]; then
        echo "[========MARIADB IS UP AND RUNNING========]"
        break
    else
        echo "[========WAITING FOR MARIADB TO START...========]"
        sleep 1
    fi
done

if [ $(date +%s) -ge $end_time ]; then
    echo "[========MARIADB DID NOT RESPOND IN TIME========]"
    exit 1
fi

#---------------------------------------------------wp installation---------------------------------------------------#

# download wordpress core files
wp core download --allow-root
# create wp-config.php file with database details
wp core config --dbhost=mariadb:3306 --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --allow-root
# install wordpress with site details
wp core install --url="$DOMAIN_NAME" --title="INCEPTION" --admin_user="$WP_ADMIN_N" --admin_password="$WP_ADMIN_P" --admin_email="$WP_ADMIN_E" --allow-root
# create a new WordPress user
wp user create "$WP_U_NAME" "$WP_U_EMAIL" --role=editor --user_pass="$WP_U_PASS" --allow-root

#---------------------------------------------------php config---------------------------------------------------#

# change listen port in php-fpm config from unix socket to port 9000
sed -i 's@listen = /run/php/php7.4-fpm.sock@listen = 9000@' /etc/php/7.4/fpm/pool.d/www.conf
# create the necessary directory for php-fpm
mkdir -p /run/php
# start php-fpm in the foreground
/usr/sbin/php-fpm7.4 -F
