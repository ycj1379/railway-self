#!/bin/sh

# configs
AUUID=ffffffff-ffff-ffff-ffff-ffffffffffff
CADDYIndexPage=https://github.com/PavelDoGreat/WebGL-Fluid-Simulation/archive/master.zip
CONFIGCADDY=https://github.com/ycj1379/Railway/raw/main/etc/Caddyfile
CONFIGXRAY=https://github.com/ycj1379/Railway/raw/main/etc/ray.json
ParameterSSENCYPT=chacha20-ietf-poly1305
StoreFiles=https://github.com/ycj1379/Railway/raw/main/etc/StoreFiles
#PORT=4433
mkdir -p /etc/caddy/ /usr/share/caddy && echo -e "User-agent: *\nDisallow: /" >/usr/share/caddy/robots.txt
wget $CADDYIndexPage -O /usr/share/caddy/index.html && unzip -qo /usr/share/caddy/index.html -d /usr/share/caddy/ && mv /usr/share/caddy/*/* /usr/share/caddy/
wget -qO- $CONFIGCADDY | sed -e "1c :$PORT" -e "s/\$AUUID/$AUUID/g" -e "s/\$MYUUID-HASH/$(caddy hash-password --plaintext $AUUID)/g" >/etc/caddy/Caddyfile
wget -qO- $CONFIGRAY | sed -e "s/\$AUUID/$AUUID/g" -e "s/\$ParameterSSENCYPT/$ParameterSSENCYPT/g" >/ray.json

# storefiles
mkdir -p /usr/share/caddy/$AUUID && wget -O /usr/share/caddy/$AUUID/StoreFiles $StoreFiles
wget -P /usr/share/caddy/$AUUID -i /usr/share/caddy/$AUUID/StoreFiles

for file in $(ls /usr/share/caddy/$AUUID); do
    [[ "$file" != "StoreFiles" ]] && echo \<a href=\""$file"\" download\>$file\<\/a\>\<br\> >>/usr/share/caddy/$AUUID/ClickToDownloadStoreFiles.html
done

# start

/ray -config /ray.json &

caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
