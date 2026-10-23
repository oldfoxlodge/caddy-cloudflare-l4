# Caddy L4 + Cloudflare DNS (Multi-Arch)

Custom multi-architecture Caddy container image with Layer 4 (caddy-l4) and Cloudflare DNS plugins.

## Integrated Plugins
- [mholt/caddy-l4](https://github.com/mholt/caddy-l4) (Layer 4 TCP/UDP routing, SNI sniffing, TLS proxy)
- [caddy-dns/cloudflare](https://github.com/caddy-dns/cloudflare) (Cloudflare DNS challenge for wildcard TLS certificates)

## Supported Architectures
- `linux/amd64`
- `linux/arm64`

## Usage with Docker Compose

```yaml
services:
  caddy:
    image: ghcr.io/oldfoxlodge/caddy-cloudflare-l4:latest
    container_name: caddy
    restart: always
    network_mode: host
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - ./data:/data
      - ./config:/config
    environment:
      - CF_API_TOKEN=your_cloudflare_api_token
```
