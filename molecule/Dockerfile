FROM ubuntu:17.10

RUN apt-get update \
 && apt-get install -y gcc python-pip python-vagrant libssl-dev libffi-dev \
 && pip install ansible docker-py molecule
