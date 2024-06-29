#!/bin/bash
# ======================================
# Autoscript Modded By SakuraV3 2024
# ======================================


#installer Websocker tunneling 

cd

apt install python -y

#Install Script Websocket-SSH Python
wget -O /usr/local/bin/edu-proxy https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/websocket/openssh.py && chmod +x /usr/local/bin/edu-proxy
wget -O /usr/local/bin/ws-dropbear https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/websocket/dropbear-ws.py.txt
wget -O /usr/local/bin/ws-stunnel https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/websocket/ws-stunnel.txt

#izin permision
chmod +x /usr/local/bin/edu-proxy
chmod +x /usr/local/bin/ws-dropbear
chmod +x /usr/local/bin/ws-stunnel
chmod +x /usr/local/bin/edu-proxyovpn

#System Direcly dropbear Websocket-SSH Python
wget -O /etc/systemd/system/edu-proxy.service  https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/websocket/http.service && chmod +x /etc/systemd/system/edu-proxy.service

#System Dropbear Websocket-SSH Python
wget -O /etc/systemd/system/ws-dropbear.service https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/websocket/service-wsdropbear.txt && chmod +x /etc/systemd/system/ws-dropbear.service

#System SSL/TLS Websocket-SSH Python
wget -O /etc/systemd/system/ws-stunnel.service https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/websocket/ws-stunnel.service.txt && chmod +x /etc/systemd/system/ws-stunnel.service

#restart service
systemctl daemon-reload

#Enable & Start & Restart ws-dropbear service
systemctl enable ws-dropbear.service
systemctl start ws-dropbear.service
systemctl restart ws-dropbear.service

#Enable & Start & Restart ws-openssh service
systemctl enable ws-stunnel.service
systemctl start ws-stunnel.service
systemctl restart ws-stunnel.service

clear
