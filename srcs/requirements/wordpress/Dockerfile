# srcs/requirements/wordpress/Dockerfile
FROM debian:bullseye

# Install necessary packages
RUN apt-get update && \
    apt-get install -y php-fpm php-mysql && wget && \
    wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    rm -rf /var/lib/apt/lists/*

# Copy WordPress configuration file
COPY conf/wp-config.php /var/www/html/wp-config.php

# Expose port 9000
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm7.4", "-F"]
