FROM php:apache 

ENV NEST_API_VERSION 1.1.4


RUN apt update && apt install -y wget cron git

RUN git clone https://github.com/mycon/nestgraph.git /var/www/html
WORKDIR /var/www/html
RUN git submodule init
RUN git submodule update
RUN wget https://d3js.org/d3.v3.min.js
#RUN wget https://github.com/gboudreau/nest-api/archive/${NEST_API_VERSION}.tar.gz \
# && tar xvf ${NEST_API_VERSION}.tar.gz \
# && mv nest-api-${NEST_API_VERSION} nest-api-master \
# && rm ${NEST_API_VERSION}.tar.gz \
RUN docker-php-ext-install mysqli \
 && docker-php-source delete
ADD cron.conf /cron.conf
ADD config.php inc/config.php
RUN crontab /cron.conf
