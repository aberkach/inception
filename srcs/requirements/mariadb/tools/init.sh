#!/bin/bash

# Start MariaDB service
service mariadb start

# Define SQL commands
SQL_SCRIPT="
CREATE DATABASE IF NOT EXISTS \$MYSQL_DATABASE_NAME;
CREATE USER IF NOT EXISTS '\$MYSQL_USER'@'%' IDENTIFIED BY '\$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON \$MYSQL_DATABASE_NAME.* TO '\$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
"

# Write and execute SQL script
echo "$SQL_SCRIPT" > db1.sql && mariadb -u root -p \$MYSQL_ROOT_PASSWORD < db1.sql && rm db1.sql

# Shutdown and restart MariaDB
mysqladmin -u root -p\$MYSQL_ROOT_PASSWORD shutdown

# Start MariaDB service
mariadbd