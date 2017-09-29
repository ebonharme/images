FROM jetty:alpine

ARG VALIDATOR_VERSION=17.7.0
USER root
RUN apk update \
 && apk --no-cache --virtual .unpack add curl unzip \
 && curl -sLo vnu.war.zip https://github.com/validator/validator/releases/download/${VALIDATOR_VERSION}/vnu.war_${VALIDATOR_VERSION}.zip \
 && unzip vnu.war.zip \
 && cp dist/vnu.war $JETTY_BASE/webapps/ROOT.war \
 && rm -fr dist vnu.war* \
 && apk del .unpack
USER jetty
