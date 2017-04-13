#!/bin/sh

cd $(dirname "$0")
docker run --rm -it -v `pwd`:/app -w /app python:2.7 ./run_tests.sh
