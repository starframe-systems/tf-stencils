#!/usr/bin/env bash

HOST=$(curl $1 | jq -r '.jwks_uri | split("/")[2]')

THUMBPRINT=$(echo | openssl s_client -servername $HOST -showcerts -connect $HOST:443 2> /dev/null \
    | sed -n -e '/BEGIN/h' -e '/BEGIN/,/END/H' -e '$x' -e '$p' | tail +2 \
    | openssl x509 -fingerprint -noout \
    | sed -e "s/.*=//" -e "s/://g" | tr "ABCDEF" "abcdef")

THUMBPRINT_JSON="{\"thumbprint\": \"${THUMBPRINT}\"}"
echo $THUMBPRINT_JSON
