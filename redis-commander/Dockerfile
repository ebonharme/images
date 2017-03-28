FROM node:4.8-alpine

ENV REDIS_HOST redis
ENV REDIS_PORT 6379

WORKDIR /app

RUN npm install -g redis-commander

EXPOSE 9000

ENTRYPOINT exec redis-commander ----redis-host ${REDIS_HOST} --redis-port ${REDIS_PORT}
