FROM python:3-alpine

RUN pip install --no-cache awscli && apk add --no-cache curl jq
ENV AWS_DEFAULT_OUTPUT=json

ADD ./docker-start.sh /
VOLUME /etc/ecs/
CMD /docker-start.sh
