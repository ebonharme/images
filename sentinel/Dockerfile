FROM redis:3-alpine

ENV SENTINEL_QUORUM 2
ENV SENTINEL_DOWN_AFTER 30000
ENV SENTINEL_FAILOVER 180000

COPY sentinel.conf /etc/redis/sentinel.conf
COPY sentinel-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/sentinel-entrypoint.sh \
 && chown redis:redis /etc/redis/sentinel.conf

EXPOSE 26379

ENTRYPOINT ["sentinel-entrypoint.sh"]
