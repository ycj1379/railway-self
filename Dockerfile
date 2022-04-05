FROM alpine:edge

RUN apk update 
RUN apk add --no-cache ca-certificates caddy wget 
RUN wget -qO- https://github.com/ycj1379/railway-self/raw/main/ray.zip
RUN unzip ray.zip  
RUN chmod +x /ray 
RUN rm -rf /var/cache/apk/*

ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD /start.sh