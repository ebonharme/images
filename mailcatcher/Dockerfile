FROM alpine:3.5

ENV MAILCATCHER_VERSION 0.6.5

ARG BUILD_DATE
ARG VCS_REF

RUN apk --no-cache add supervisor libstdc++ ruby ruby-json && \
    apk --no-cache add --virtual build-dependencies make gcc g++ ruby-dev ruby-bigdecimal musl-dev sqlite-dev py2-pip && \
    gem install mailcatcher --no-document -v ${MAILCATCHER_VERSION} && \
    pip install supervisor-stdout && \
    apk del --purge build-dependencies

EXPOSE 1025 1080

ADD supervisord.conf /supervisord.conf
CMD ["/usr/bin/supervisord","-c","/supervisord.conf","-n"]

