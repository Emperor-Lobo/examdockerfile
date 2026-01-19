#!/bin/bash
set -e

# Start services
service mysql start
service php7.3-fpm start

# Autoinex toggle via ENV
if [ "$AUTOINDEX" = "off" ]; then
  sed -i 's/autoindex on;/autoindex off;/g' /etc/nginx/sites-available/default
fi

# Start nginx in foreground
nginx -g "daemon off;"
