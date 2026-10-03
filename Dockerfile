FROM caddy/caddy:builder-alpine AS builder

RUN xcaddy build v2.11.7 \
    --with github.com/caddy-dns/ovh \
    --with github.com/mholt/caddy-ratelimit \
    --with github.com/porech/caddy-maxmind-geolocation


FROM caddy:alpine

ENV CADDY_VERSION=v2.11.7

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
