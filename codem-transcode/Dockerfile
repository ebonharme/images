FROM jrottenberg/ffmpeg:3.2

ENV SOURCE_REF v1.0
ENV SOURCE_URL https://github.com/madebyhiro/codem-transcode.git


RUN apt-get update \
 && apt-get install -y curl git \
 && curl -sL https://deb.nodesource.com/setup_7.x | bash - \
 && git clone ${SOURCE_URL} /app \
 && cd /app \
 && git checkout  ${SOURCE_REF} \
 && apt-get install -y nodejs \
 && npm install -g

EXPOSE 8282

ENTRYPOINT ["codem-transcode"]
