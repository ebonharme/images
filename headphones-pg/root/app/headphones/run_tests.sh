#!/bin/sh

pip install -r requirements-dev.txt

pep8 headphones
pyflakes headphones
nosetests
