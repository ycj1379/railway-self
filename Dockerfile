FROM debian
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install ssh wget git unzip screen -y
RUN echo 'wget -O start.sh https://www.baipiao.eu.org/onekey_vmess.sh && bash install.sh' >>/start.sh
RUN chmod 755 /start.sh
EXPOSE 80
CMD  /start.sh
