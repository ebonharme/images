#!/bin/sh

if [ "$GENERATE_CERTIFICATE" == "true" ]; then
  openssl req -newkey rsa:4096 -x509 -keyout /etc/squid/squid.key -out /etc/squid/squid.pem -days 365 -nodes -subj "/CN=${HOSTNAME}/O=My Company Name LTD./C=US"
fi

chown root:root /etc/squid/squid.pem /etc/squid/squid.key
chmod 400 /etc/squid/squid.key

squid -k parse
squid -YN -f /etc/squid/squid.conf
# Consider 'C' flag to not catch fatal signal
