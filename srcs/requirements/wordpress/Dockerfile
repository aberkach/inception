 # srcs/requirements/wordpress/Dockerfile
FROM debian:bullseye

RUN apt-get -y update && apt-get -y upgrade &&\
    apt-get install -y wget && \
    apt-get install -y php8.2 && \
	apt-get install -y php-fpm && \
	apt-get install -y php-mysql && \
	apt-get install -y mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.5-fr_FR.tar.gz -P /var/www/html/ && \
    cd /var/www/html/ && \
    tar -xvf wordpress-6.5-fr_FR.tar.gz && \
    rm -rf /var/www/html/wordpress-6.5-fr_FR.tar.gz && \
    chown -R www-data:www-data /var/www/html/wordpress


CMD ["php-fpm"]
