FROM debian:bullseye

# Install nginx and openssl
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get install -y nginx && apt-get install openssl && \
    rm -rf /var/lib/apt/lists/*

# Generate SSL certificate
RUN mkdir /etc/nginx/ssl && \
openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
/etc/nginx/ssl/inception.key -subj "/C=MA/ST=Khouribga/L=Khouribga/O=1337/CN=localhost"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html

RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]
