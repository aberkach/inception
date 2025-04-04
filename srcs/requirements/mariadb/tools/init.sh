#!/bin/bash

# Start MariaDB
service mariadb start

# Wait for MariaDB to start
sleep 5

# Create database and user for WordPress to use (if not exist) and grant all privileges
mariadb -u root -e "
CREATE DATABASE IF NOT EXISTS $MYSQL_DB;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DB.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
"

# stop MariaDB
service mariadb stop

# Start MariaDB in the background
mysqld_safe
