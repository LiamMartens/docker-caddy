FROM liammartens/alpine
LABEL maintainer="Liam Martens <hi@liammartens.com>"

# plugins
ENV plugins=http.cache,http.cgi,http.cors,http.expires,http.ipfilter,http.minify,http.nobots,http.proxyprotocol,http.ratelimit
ENV license=personal

RUN mkdir /home/www-data/caddy /home/www-data/caddy/log /home/www-data/caddy/conf /var/www
WORKDIR /home/www-data/caddy

# add some packages
RUN apk add tar

# download and extract caddy
RUN curl https://getcaddy.com | bash -s ${license} ${plugins}

# volumes
# hidden caddy dir (ssl certs, ...)
# caddy log
# caddy conf directory
# content directory
VOLUME /home/www-data/caddy/.caddy /home/www-data/caddy/log /home/www-data/caddy/conf /var/www

# copy continue file
COPY scripts/continue.sh ${ENV_DIR}/scripts/continue.sh
RUN chmod +x ${ENV_DIR}/scripts/continue.sh