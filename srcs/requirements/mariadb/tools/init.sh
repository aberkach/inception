#!/bin/bash

# mariadb start
service mariadb start

# Wait for mariadb to start
sleep 3

# Create database if not exists
mariadb -e "CREATE DATABASE IF NOT EXISTS \$MYSQL_DATABASE;"

# Create user if not exists
mariadb -e "CREATE USER IF NOT EXISTS '\$MYSQL_USER'@'%' IDENTIFIED BY '\$MYSQL_PASSWORD';"

# Grant privileges to user
mariadb -e "GRANT ALL PRIVILEGES ON \$MYSQL_DATABASE.* TO '\$MYSQL_USER'@'%';" 

# Flush privileges to apply changes
mariadb -e "FLUSH PRIVILEGES;"

# Shutdown mariadb to restart with new config
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

# Restart mariadb with new config in the background to keep the container running
exec mysqld_safe