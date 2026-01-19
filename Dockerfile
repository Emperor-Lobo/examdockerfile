FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive
ENV AUTOINDEX=on

RUN sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list


RUN apt-get update && apt-get install -y \
    nginx \
    mariadb-server \
    php7.3-fpm php7.3-mysql php7.3-mbstring php7.3-zip php7.3-gd php7.3-xml php7.3-curl \
    wget tar unzip \
    && rm -rf /var/lib/apt/lists/*

# Create DB + user
RUN service mysql start && \
    mysql -e "CREATE DATABASE wordpress;" && \
    mysql -e "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'wppassword';" && \
    mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';" && \
    mysql -e "FLUSH PRIVILEGES;"

# WordPress
RUN wget -q https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress /var/www/html/wordpress && \
    rm latest.tar.gz

# phpMyAdmin
RUN mkdir -p /var/www/html/phpmyadmin && \
    wget -q https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz && \
    tar -xzf phpMyAdmin-latest-all-languages.tar.gz && \
    mv phpMyAdmin-*/* /var/www/html/phpmyadmin && \
    rm -rf phpMyAdmin-* phpMyAdmin-latest-all-languages.tar.gz

# Basic index.php
COPY index.php /var/www/html/index.php

COPY nginx/default.conf /etc/nginx/sites-available/default
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80

CMD ["/start.sh"]
