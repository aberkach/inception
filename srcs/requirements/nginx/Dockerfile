# srcs/requirements/nginx/Dockerfile
FROM debian:bullseye

# Install nginx and openssl
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Generate SSL certificate
RUN mkdir /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt -subj "/C=MA/ST=Khouribga/L=Khouribga/O=1337/CN=inception"

COPY conf/default /etc/nginx/sites-available/default

RUN chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

# Expose port 443
EXPOSE 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
