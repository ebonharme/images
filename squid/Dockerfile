FROM alpine:3.7

RUN apk add --no-cache squid ca-certificates libressl && \
    /usr/lib/squid/ssl_crtd -c -s /var/lib/ssl_db
COPY squid.conf /etc/squid/squid.conf
COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN chmod 755 /usr/bin/docker-entrypoint.sh
EXPOSE 3128
VOLUME /etc/squid/squid.pem /etc/squid/squid.key
ENTRYPOINT /usr/bin/docker-entrypoint.sh
