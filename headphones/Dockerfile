FROM python:2-alpine

ENV SOURCE_REF v0.5.18
ENV SOURCE_URL https://github.com/rembo10/headphones.git

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/ebonharme/images.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1"
    
RUN apk update \
 && apk add git \
 && git clone ${SOURCE_URL} /app \
 && cd /app \
 && git checkout -b deploybranch ${SOURCE_REF} \
 && apk remove git \
 && rm -fr .git

EXPOSE 8181

WORKDIR /app

ADD start.sh /app/start.sh

ENTRYPOINT /app/start.sh
