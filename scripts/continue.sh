#!/bin/sh
export HOME=/home/www-data

# set timezone
cat /usr/share/zoneinfo/UTC > /etc/localtime
echo UTC > /etc/timezone

# run user scripts
if [[ -d ./files/.$(whoami) ]]; then
	chmod +x ./files/.$(whoami)/*
	run-parts ./files/.$(whoami)
fi

# start caddy
echo "Starting Caddy"
caddy --conf $HOME/caddy/conf/Caddyfile --log $HOME/caddy/log/caddy.log

$SHELL