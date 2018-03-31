#!/bin/sh

env

if [ "$GENERATE_CERTIFICATE" == "true" ]; then
  openssl req -newkey rsa:4096 -x509 -keyout /etc/squid/squid.key -out /etc/squid/squid.pem -days 365 -nodes -subj "/CN=${HOSTNAME}/O=My Company Name LTD./C=US"
else
  ls -la $CERTIFICATE $KEY
  cp $CERTIFICATE /etc/squid/squid.pem
  cp $KEY /etc/squid/squid.key
fi

chown root:root /etc/squid/squid.pem /etc/squid/squid.key
chmod 400 /etc/squid/squid.key

ls -la /etc/squid/squid.key /etc/squid/squid.pem
squid -k parse
squid -YN -f /etc/squid/squid.conf
# Consider 'C' flag to not catch fatal signal
