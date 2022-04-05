FROM alpine:edge

RUN apk update && \
    apk add --no-cache ca-certificates caddy tor wget && \
    wget -qO- https://github.com/ycj1379/Railway/raw/main/etc/ray.zip | busybox unzip - && \
    chmod +x /ray && \
    rm -rf /var/cache/apk/*

ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD /start.sh
https://github.com/ycj1379/Railway/raw/main/etc/ray.json