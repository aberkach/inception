FROM debian:bullseye

# Install nginx and openssl
RUN apt-get -y update && \
    apt-get install -y nginx openssl
    
# Generate SSL certificate and key
RUN mkdir /etc/nginx/ssl \
    && openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
    /etc/nginx/ssl/inception.key -subj "/C=MO/ST=KH/L=KH/O=1337/CN=localhost.fr/UID=abdelfatah" 

# Copy the nginx configuration file
COPY /conf/nginx.conf etc/nginx/sites-available/default

# Start nginx
CMD ["nginx", "-g", "daemon off;"]

