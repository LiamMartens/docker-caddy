#!/bin/sh
export HOME=/home/www-data

# set timezone
cat /usr/share/zoneinfo/UTC > /etc/localtime
echo UTC > /etc/timezone

echo "Starting Caddy"
caddy --conf $HOME/caddy/conf/Caddyfile --log $HOME/caddy/log/caddy.log

exec "$@"