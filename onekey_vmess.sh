#!/bin/bash
rm -rf ray cloudflared-linux-amd64 ray.zip
wget https://github.com/ycj1379/railway-self/raw/main/ray.zip
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
chmod +x cloudflared-linux-amd64
chmod +x ray/ray
unzip -d ray ray.zip
rm -rf ray.zip
wget  -O ray/config.json https://github.com/ycj1379/railway-self/raw/main/config.json
ray/ray &
./cloudflared-linux-amd64 tunnel --url http://localhost:8888 --no-autoupdate>argo.log 2>&1 &
sleep 2
echo 等到cloudflare argo生成地址
sleep 3
argo=$(cat argo.log | grep trycloudflare.com | awk 'NR==2{print}' | awk -F// '{print $2}' | awk '{print $1}')
clear
echo vmess链接已经生成,IP地址可替换为CF优选IP
echo 'vmess://'$(echo '{"add":"66.235.200.230","aid":"0","host":"'$argo'","id":"ffffffff-ffff-ffff-ffff-ffffffffffff","net":"ws","path":"","port":"443","ps":"argo v2ray","tls":"tls","type":"none","v":"2"}' | base64 -w 0)
cat argo.log
