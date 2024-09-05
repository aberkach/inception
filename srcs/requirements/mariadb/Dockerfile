# srcs/requirements/mariadb/Dockerfile
FROM debian:bullseye

# Install mariadb
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Copy the mariadb script initialization
COPY /tools/init.sh /tmp/init.sh

CMD ["./tmp/init.sh"]
