FROM alpine:edge
MAINTAINER hi@liammartens.com (hi@liammartens.com)

# add user www-data
RUN adduser -D www-data
RUN mkdir /home/www-data/caddy && mkdir /home/www-data/caddy/log && mkdir /home/www-data/caddy/conf
WORKDIR /home/www-data/caddy

# update repos and upgrade
RUN apk update && apk upgrade

# add some packages
RUN apk add tar curl

# set build agrument plugins
ARG plugins=cors,expires,git,ipfilter,jsonp,locale,minify,realip

# download and extract caddy
RUN curl --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - "https://caddyserver.com/download/build?os=linux&arch=amd64&features=${plugins}" > caddy.zip && tar -xzf caddy.zip caddy && rm caddy.zip

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

ENTRYPOINT ["/home/www-data/run.sh", "su", "-m", "www-data", "-c", "/home/www-data/continue.sh /bin/sh"]