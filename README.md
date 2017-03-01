# Caddy Docker Image

## Plugins
This image contains the following plugins by default but this can be changed by passing a build argument.
* cors
* expires
* git
* ipfilter
* jsonp
* locale
* minify
* realip

## Volumes
Defines 4 volumes
* /home/www-data/caddy/.caddy : for the persistent caddy files (such as Let's Encrypt certificates)
* /home/www-data/caddy/log : for the caddy.log file
* /home/www-data/caddy/conf : for the Caddyfile configuration
* /var/www : for the content