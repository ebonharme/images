# docker run  -d \
#  --name=PlexPy \
#  -v <path to local plexpy data>:/data \
#  -p 8181:8181 \
#  ebonharme/images:plexpy
FROM alpine:latest

ENV PLEXPY_VERSION v1.4.17

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/ebonharme/images.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1"
      
# Install required packages.
RUN apk add --no-cache \
	ca-certificates \
	git \
	python \
	py-openssl \
 && git clone https://github.com/JonnyWong16/plexpy.git /opt/plexpy \
 && ( \
    cd /opt/plexpy \
    && git checkout "${PLEXPY_VERSION}" \
)

# Volume for Plexpy data.
VOLUME /data

# Set the working directory.
WORKDIR /opt/plexpy

# Expose ports.
EXPOSE 8181

# Define default command.
ENTRYPOINT ["python", "PlexPy.py"]
CMD ["--nolaunch", "--datadir=/data"]
