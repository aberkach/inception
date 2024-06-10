# srcs/requirements/mariadb/Dockerfile
FROM debian:bullseye

RUN apt-get -y update && apt-get -y upgrade && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY /conf/ /etc/mysql/mariadb.conf.d/mariadb-server.cnf

COPY /tools/init.sh /tmp/init.sh

RUN chmod +x /tmp/init.sh

CMD ["./tmp/init.sh"]
