FROM php:apache

ENV APP_VERSION 1.3.0
ENV MEMCACHED_HOST 127.0.0.1
ENV MEMCACHED_PORT 11211

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/ebonharme/images.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1"

COPY Memcache.php /var/www/html/Config/

RUN cd /tmp/ \
 && curl -sLo app.tar.gz https://github.com/elijaa/phpmemcachedadmin/archive/${APP_VERSION}.tar.gz \
 && tar xf app.tar.gz \
 && cp -rf phpmemcachedadmin-${APP_VERSION}/* /var/www/html/ \
 && rm -rf phpmemcachedadmin-${APP_VERSION} app.tar.gz \
 && chown -R www-data:www-data /var/www/html
