FROM debian:bullseye

# Install nginx and openssl
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get install -y nginx && apt-get install openssl && \
    rm -rf /var/lib/apt/lists/*
    
# Generate SSL certificate and key && create the directory for wordpress
RUN mkdir /etc/nginx/ssl \
    && openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
    /etc/nginx/ssl/inception.key -subj "/C=MO/ST=KH/L=KH/O=42/CN=localhost.fr/UID=abdelfatah" 
    
# Copy the nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

#create the wordpress directory
RUN mkdir -p /var/www/wordpress

# Set the appropriate permissions for the wordpress directory
RUN chown -R www-data:www-data /var/www/wordpress

CMD ["nginx", "-g", "daemon off;"]
