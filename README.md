# caddy-custom

Custom Caddy Docker image built automatically with [xcaddy](https://github.com/caddyserver/xcaddy) and published to GitHub Container Registry.

## Included plugins

| Plugin | Description |
|--------|-------------|
| [`caddy-dns/ovh`](https://github.com/caddy-dns/ovh) | DNS-01 challenge via OVH API (useful for wildcard certificates) |
| [`mholt/caddy-ratelimit`](https://github.com/mholt/caddy-ratelimit) | Native rate limiting in Caddy |

## Available images

```
ghcr.io/<owner>/<repo>:latest
ghcr.io/<owner>/<repo>:<YYYYMMDD>
ghcr.io/<owner>/<repo>:<version>   # e.g. v2.11.4
```

## Usage

```yaml
# docker-compose.yml
services:
  caddy:
    image: ghcr.io/<owner>/<repo>:latest
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
      - "443:443/udp"
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - caddy_data:/data
      - caddy_config:/config

volumes:
  caddy_data:
  caddy_config:
```

## Automatic updates

A GitHub Actions workflow checks every 12 hours whether a new version of Caddy is available. If so, it:

1. Updates the `Dockerfile`
2. Builds and publishes a new image to GHCR
3. Creates a GitHub release with the corresponding tags

## Manual build## Manual build

```bash
docker build -t caddy-custom .
```

## Dockerfile

```dockerfile
FROM caddy/caddy:builder-alpine AS builder
RUN xcaddy build v2.11.4 \
    --with github.com/caddy-dns/ovh \
    --with github.com/mholt/caddy-ratelimit

FROM caddy:alpine
ENV CADDY_VERSION=v2.11.4
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
```
