FROM linuxserver/headphones

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/ebonharme/images.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1"

RUN apk update \
 && apk add nfs-utils

ADD start.sh /start.sh

EXPOSE 8181 443

ENTRYPOINT /start.sh
