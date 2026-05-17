FROM caddy/caddy:builder-alpine AS builder

RUN xcaddy build v2.11.3 \
    --with github.com/caddy-dns/ovh \
    --with github.com/mholt/caddy-ratelimit

FROM caddy:alpine

ENV CADDY_VERSION=v2.11.3

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
