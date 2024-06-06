# srcs/requirements/mariadb/Dockerfile
FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY /tools/init.sh /tmp/init.sh

EXPOSE 3306

CMD ["./tmp/init.sh"]
