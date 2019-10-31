#!/bin/bash


exec /root/ubik name=docker-gen  docker-gen -watch -notify "cat /etc/Caddyfile && killall -SIGUSR1 caddy" /etc/caddy/Caddyfile.template /etc/caddy/Caddyfile
      ---       name=caddy       pause=10  caddy -quic -conf /etc/caddy/Caddyfile
      ---       name=conf        pause=5  /usr/bin/tail -f /etc/caddy/Caddyfile
