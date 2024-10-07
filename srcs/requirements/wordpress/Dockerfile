# pull the base image
FROM debian:bullseye

# update and upgrade the system

# install the required packages
RUN apt-get update \
    && apt-get install -y php7.4-fpm \
    php-mysql \
    mariadb-client \
    curl


# download wp-cli
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O 

# copy the wp-init.sh file
COPY /conf/init-wp.sh /tmp/wp-init.sh

# give the right permissions to the wp-cli file  and move it to the bin directory
RUN chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp 

# run the wp-init.sh file
CMD ["bash", "/tmp/wp-init.sh"]