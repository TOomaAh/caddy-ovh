FROM caddy:builder-alpine AS builder


RUN xcaddy build v2.9.1 \
    --with github.com/caddy-dns/ovh

FROM caddy:alpine

ENV CADDY_VERSION=v2.9.1

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
