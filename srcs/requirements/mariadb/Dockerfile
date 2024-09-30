FROM debian:bullseye

# Install mariadb
RUN apt-get -y update \
    && apt-get install -y mariadb-server

# Copy the mariadb script initialization and set permissions
COPY /tools/init.sh /tmp/init.sh

# Copy the mariadb configuration file
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

#expose the port
EXPOSE 3306

# Run the mariadb script initialization
CMD ["bash", "/tmp/init.sh"]