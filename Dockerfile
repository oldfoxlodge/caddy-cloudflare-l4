# syntax=docker/dockerfile:1

# 利用 Go 原生交叉编译，直接跑在 Runner 宿主机的原生 x86 算力上
FROM --platform=$BUILDPLATFORM caddy:2-builder-alpine AS builder

ARG TARGETOS
ARG TARGETARCH

# CGO_ENABLED=0 产出静态二进制，@master 锁定 10 月中旬修复 EOF 的最新代码
RUN CGO_ENABLED=0 \
    GOOS=${TARGETOS} \
    GOARCH=${TARGETARCH} \
    xcaddy build \
      --with github.com/mholt/caddy-l4@master \
      --with github.com/caddy-dns/cloudflare \
      --output /usr/bin/caddy

# 多架构运行时轻量底座 (仅 ~45MB)
FROM caddy:2-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
