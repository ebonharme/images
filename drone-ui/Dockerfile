FROM node:4.8-alpine

ENV SOURCE_REF master
ENV SOURCE_URL https://github.com/drone/drone-ui.git

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
 && npm install \
 && apk del git \
 && rm -fr .git

EXPOSE 9000

WORKDIR /app
ENTRYPOINT exec npm start -- --scheme ${DRONE_SCHEME} --host ${DRONE_HOST} -- ${DRONE_TOKEN}
