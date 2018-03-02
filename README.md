# Caddy Docker Image

[![](https://images.microbadger.com/badges/image/liammartens/caddy.svg)](https://microbadger.com/images/liammartens/caddy "Get your own image badge on microbadger.com")

[![](https://images.microbadger.com/badges/version/liammartens/caddy.svg)](https://microbadger.com/images/liammartens/caddy "Get your own version badge on microbadger.com")

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
* `/var/www` For web content

## Logging
All logs are written to `stdout`