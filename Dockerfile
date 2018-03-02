# @arg Override the alpine non-root user
ARG USER=www-data
FROM liammartens/alpine
LABEL maintainer="Liam Martens <hi@liammartens.com>"

# @arg Define the Caddy plugins
ARG PLUGINS=http.cache,http.cgi,http.cors,http.expires,http.ipfilter,http.minify,http.nobots,http.proxyprotocol,http.ratelimit

# @arg Define the Caddy license
ARG LICENSE=personal

# @user Set user to root for installation
USER root

# @run add necessary packages
RUN apk add tar libcap

# @env set plugins and license
ENV PLUGINS=${PLUGINS}
ENV LICENSE=${LICENSE}

# @run mkdirs
RUN mkdir -p /etc/caddy /var/www

# @copy Copy default caddyfile
COPY conf/Caddyfile /etc/caddy/

# @run chown the dirs
RUN chown -R ${USER}:${USER} /etc/caddy /var/www

# @run chmod the dirs
RUN chmod -R 750 /etc/caddy /var/www

# @run download and extract caddy
RUN curl https://getcaddy.com | bash -s ${LICENSE} ${PLUGINS}

# @run allow caddy to bind to ports without root
RUN setcap 'cap_net_bind_service=+ep' $(which caddy)

# @user Set user back to non-root
USER ${USER}

# @healthcheck Define healthcheck
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=2 CMD [[ $(pgrep -x "caddy") ]] || exit 1

# @cmd Set caddy command
CMD [ "-c", "caddy -conf /etc/caddy/Caddyfile -log stdout -root /var/www" ]