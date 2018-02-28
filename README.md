# Caddy Docker Image

## Plugins
This image contains the following plugins by default but this can be changed by passing a build argument.
* cache
* cgi
* cors
* expires
* ipfilter
* minify
* nobots
* proxyprotocol
* ratelimit

## Directories
* `/home/www-data/.caddy` For persistent caddy files (Let's Encrypt)
* `/etc/caddy` For the Caddy configuration files (a default one is copied in this directory if you don't bind the volume)
* `/var/log/caddy` For caddy log files
* `/var/www` For web content