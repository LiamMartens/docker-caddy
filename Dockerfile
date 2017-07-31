FROM alpine:edge
MAINTAINER hi@liammartens.com (hi@liammartens.com)
ENV CADDY_VERSION=0.10.6

# add user www-data
RUN adduser -D www-data
RUN mkdir /home/www-data/caddy /home/www-data/caddy/log /home/www-data/caddy/conf /var/www
WORKDIR /home/www-data/caddy

# update repos and upgrade
RUN apk update && apk upgrade

# add some packages
RUN apk add tar curl tzdata bash

# download and extract caddy
RUN curl https://getcaddy.com | bash -s http.cache,http.cgi,http.cors,http.expires,http.filter,http.ipfilter,http.jwt,http.login,http.mailout,http.minify,http.nobots,http.proxyprotocol,http.ratelimit,http.realip,http.restic,tls.dns.cloudflare

# define volumes
# hidden caddy dir (ssl certs, ...)
# caddy log
# caddy conf directory
# content directory
VOLUME [ "/home/www-data/caddy/.caddy", "/home/www-data/caddy/log", "/home/www-data/caddy/conf", "/var/www" ]

# copy run file
COPY scripts/run.sh /home/www-data/run.sh
RUN chmod +x /home/www-data/run.sh
COPY scripts/continue.sh /home/www-data/continue.sh
RUN chmod +x /home/www-data/continue.sh

# chown
RUN touch /etc/localtime /etc/timezone && chown -R www-data:www-data /home/www-data /etc/localtime /etc/timezone /var/www

ENTRYPOINT ["/home/www-data/run.sh", "su", "-m", "www-data", "-c", "/home/www-data/continue.sh /bin/sh"]