FROM jetty:alpine

RUN apk update \
 && apk --no-cache --virtual .unpack add curl unzip \
 && curl -sLo vnu.war.zip https://github.com/validator/validator/releases/download/17.2.1/vnu.war_17.2.1.zip \
 && unzip vnu.war.zip \
 && cp dist/vnu.war $JETTY_BASE/webapps/ROOT.war \
 && rm -fr dist vnu.war* \
 && apk del .unpack
