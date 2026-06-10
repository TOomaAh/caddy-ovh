FROM caddy/caddy:builder-alpine AS builder

RUN xcaddy build null \
    --with github.com/caddy-dns/ovh \
    --with github.com/mholt/caddy-ratelimit

FROM caddy:alpine

ENV CADDY_VERSION=null

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
