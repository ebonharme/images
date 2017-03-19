FROM debian:jessie-backports

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/ebonharme/images.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1"

RUN groupadd -r -g 666 sabnzbd \
    && useradd -l -r -u 666 -g 666 -d /sabnzbd sabnzbd

ADD sabnzbd.sh /sabnzbd.sh
RUN chmod 755 /sabnzbd.sh

ENV LANG C.UTF-8

#
# Install SABnzbd and all required dependencies.
#

RUN export SABNZBD_VERSION=1.2.3 PAR2CMDLINE_VERSION=v0.6.14 \
    && export DEBIAN_FRONTEND=noninteractive \
    && export BUILD_PACKAGES="automake build-essential curl" \
    && export RUNTIME_BACKPORTS_PACKAGES="openssl python-cryptography python-openssl nfs-common" \
    && export RUNTIME_PACKAGES="ca-certificates p7zip-full python-cheetah python-yenc unrar unzip" \
    && sed -i "s/ main$/ main contrib non-free/" /etc/apt/sources.list \
    && apt-get -q update \
    && apt-get install -qqy $BUILD_PACKAGES $RUNTIME_PACKAGES \
    && apt-get -t jessie-backports install -qqy $RUNTIME_BACKPORTS_PACKAGES \
    && curl -SL -o /tmp/sabnzbd.tar.gz https://github.com/sabnzbd/sabnzbd/releases/download/${SABNZBD_VERSION}/SABnzbd-${SABNZBD_VERSION}-src.tar.gz \
    && tar xzf /tmp/sabnzbd.tar.gz \
    && mv SABnzbd-* sabnzbd \
    && chown -R sabnzbd: sabnzbd \
    && curl -o /tmp/par2cmdline.tar.gz https://codeload.github.com/Parchive/par2cmdline/tar.gz/${PAR2CMDLINE_VERSION} \
    && tar xzf /tmp/par2cmdline.tar.gz -C /tmp \
    && cd /tmp/par2cmdline-* \
    && aclocal \
    && automake --add-missing \
    && autoconf \
    && ./configure \
    && make \
    && make install \
    && export AUTO_ADDED_PACKAGES="$(apt-mark showauto)" \
    && apt-get -y remove --purge $BUILD_PACKAGES $AUTO_ADDED_PACKAGES \
    && apt-get -y autoremove \
    && apt-get install -qqy $RUNTIME_PACKAGES \
    && apt-get -t jessie-backports install -qqy $RUNTIME_BACKPORTS_PACKAGES \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && cd / \
    && rm -rf /tmp/*

#
# Define container settings.
#

VOLUME ["/mnt/Downloads", "/config"]

EXPOSE 8080 443

WORKDIR /sabnzbd

CMD ["/sabnzbd.sh"]
