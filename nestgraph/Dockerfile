FROM php:apache 

ENV NEST_API_VERSION 1.1.4

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/ebonharme/images.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1"
    
ADD cron.conf /cron.conf

RUN apt update \
 && apt install -y wget cron git libxml2-dev libcurl4-openssl-dev \
 && git clone https://github.com/mycon/nestgraph.git /var/www/html \
 && git submodule init \
 && git submodule update \
 && wget https://d3js.org/d3.v3.min.js \
 && docker-php-ext-install mysqli xml curl \
 && docker-php-source delete \
 && crontab /cron.conf
ADD config.php /var/www/html/inc/config.php
