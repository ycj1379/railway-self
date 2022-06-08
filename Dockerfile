FROM debian
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install ssh wget git unzip screen -y
RUN echo 'wget -O start.sh https://github.com/ycj1379/railway-self/raw/main/start.sh && bash install.sh' >>/start.sh
RUN chmod 755 /start.sh
EXPOSE 80
CMD  /start.sh
