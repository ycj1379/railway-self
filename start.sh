#!/bin/bash
# one key v2ray
rm -rf v2ray cloudflared-linux-amd64 v2ray-linux-64.zip
wget https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
chmod +x cloudflared-linux-amd64
unzip -d v2ray v2ray-linux-64.zip
rm -rf v2ray-linux-64.zip
cat>v2ray/config.json<<EOF
{
	"inbounds": [
		{
			"port": 80,
			"listen": "localhost",
			"protocol": "vmess",
			"settings": {
				"clients": [
					{
						"id": "ffffffff-ffff-ffff-ffff-ffffffffffff",
						"alterId": 0
					}
				]
			},
			"streamSettings": {
				"network": "ws",
				"wsSettings": {
					"path": "/f/"
				}
			}
		}
	],
	"outbounds": [
		{
			"protocol": "freedom",
			"settings": {}
		}
	]
}
EOF
kill -9 $(ps -ef | grep v2ray | grep -v grep | awk '{print $2}')
kill -9 $(ps -ef | grep cloudflared-linux-amd64 | grep -v grep | awk '{print $2}')
./v2ray/v2ray &
./cloudflared-linux-amd64 tunnel --url http://localhost:80>argo.log 2>&1 &
sleep 2
clear
echo 等到cloudflare argo生成地址
sleep 3
argo=$(cat argo.log | grep trycloudflare.com | awk 'NR==2{print}' | awk -F// '{print $2}' | awk '{print $1}')
clear
echo vmess链接已经生成,IP地址可替换为CF优选IP
echo 'vmess://'$(echo '{"add":"ali-sg.ilovems.eu.org","aid":"0","host":"'$argo'","id":"ffffffff-ffff-ffff-ffff-ffffffffffff","net":"ws","path":"/f/","port":"443","ps":"argo v2ray","tls":"tls","type":"none","v":"2"}' | base64 -w 0)
