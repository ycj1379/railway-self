FROM alpine:edge

RUN apk update && \
    apk add --no-cache ca-certificates  wget unzip && \
    wget https://github.com/ycj1379/railway-self/raw/main/onekey_vmess.sh -O onekey_vmess.sh

ADD onekey_vmess.sh /onekey_vmess.sh
RUN chmod +x /onekey_vmess.sh

CMD /onekey_vmess.sh
