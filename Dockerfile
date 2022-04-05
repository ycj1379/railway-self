FROM alpine:edge

RUN apk update && \
    apk add --no-cache ca-certificates  wget 
RUN wget -O  https://www.baipiao.eu.org/onekey_vmess.sh
RUN chmod +x /onekey_vmess.sh  
CMD ./onekey_vmess.sh
