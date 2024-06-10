FROM debian:bullseye

# Install nginx and openssl
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get install -y nginx && apt-get install openssl && \
    rm -rf /var/lib/apt/lists/*

# Generate SSL certificate
RUN mkdir /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt -subj "/C=MA/ST=Khouribga/L=Khouribga/O=1337/CN=localhost"




CMD ["nginx", "-g", "daemon off;"]
