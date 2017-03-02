#!/bin/sh
chown -R www-data:www-data /var/www /home/www-data
exec "$@"