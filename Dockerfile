FROM alpine:edge

RUN apk update && \
    apk add --no-cache ca-certificates caddy wget && \
    wget -qO- https://github.com/ycj1379/railway-self/raw/main/ray.zip | busybox unzip ray.zip  && \
    chmod +x /ray && \
    rm -rf /var/cache/apk/*

ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD /start.sh