FROM php:apache 

ENV NEST_API_VERSION 1.1.4

ADD cron.conf /cron.conf

RUN apt update && apt install -y wget cron git libxml2-dev libcurl4-openssl-dev
RUN git clone https://github.com/mycon/nestgraph.git /var/www/html
WORKDIR /var/www/html
RUN git submodule init \
 && git submodule update \
 && wget -O d3.min.js https://d3js.org/d3.v3.min.js \
 && docker-php-ext-install mysqli xml curl \
 && docker-php-source delete \
 && crontab /cron.conf
ADD config.php inc/config.php
