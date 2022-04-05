FROM alpine:edge

RUN apk update && \
    apk add --no-cache ca-certificates  wget unzip && \
    wget https://github.com/ycj1379/railway-self/raw/main/start.sh && \
    ls -lh
ADD onekey_vmess.sh /start.sh
RUN chmod +x /start.sh

CMD /start.sh
