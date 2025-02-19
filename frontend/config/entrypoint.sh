#!/usr/bin/env sh
set -eu
export SERVER_HOST="${SERVER_HOST:=server}"

if [ ! -f /etc/fallback-certs/resty-auto-ssl-fallback.crt ]; then
  openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
    -subj '/CN=sni-support-required-for-valid-ssl' \
    -keyout /etc/fallback-certs/resty-auto-ssl-fallback.key \
    -out /etc/fallback-certs/resty-auto-ssl-fallback.crt
fi
envsubst '${SERVER_HOST}' < /etc/openresty/nginx.conf.template > /etc/openresty/nginx.conf

exec "$@"
