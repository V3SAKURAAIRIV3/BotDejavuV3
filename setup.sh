#!/bin/bash
# ======================================
# Autoscript Modded By SakuraV3 2024
# ======================================

MYIP=$(curl -sS ipv4.icanhazip.com)
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
MYIP=$(wget -qO- ipinfo.io/ip);

#figlet
apt-get install figlet -y
apt-get install ruby -y
gem install lolcat

echo "Checking VPS" | lolcat
sleep 0.5
clear
CEKEXPIRED () {
today=$(date -d +1day +%Y -%m -%d)
Exp1=$(curl -sS https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/izin | grep $MYIP | awk '{print $3}')   
if [[ $today < $Exp1 ]]; then
echo -e "\e[32mSTATUS SCRIPT AKTIF...\e[0m"
else
echo -e "\e[31mSCRIPT ANDA EXPIRED!\e[0m";
exit 0
fi
}
IZIN=$(curl -sS https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/izin | awk '{print $4}' | grep $MYIP)   
if [ $MYIP = $IZIN ]; then
echo "VPS KAMU DI TERIMA!!"
else
echo "VPS KAMU DI TOLAK";
exit 0
fi
localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi
if [ -f "/root/log-install.txt" ]; then
rm -fr /root/log-install.txt
fi
mkdir -p /etc/xray
mkdir -p /etc/v2ray
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/scdomain
touch /etc/v2ray/scdomain
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1
apt install git curl -y >/dev/null 2>&1
apt install python -y >/dev/null 2>&1
echo -e "[ ${green}INFO${NC} ] Aight good ... installation file is ready"
sleep 2
mkdir -p /var/lib/scrz-prem >/dev/null 2>&1
echo "IP=" >> /var/lib/scrz-prem/ipvps.conf
sudo apt install vnstat
sudo apt insta squid
wget -q -O https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/system/tools.sh && chmod +x tools.sh && ./tools.sh
rm tools.sh
clear
figlet "DOMAIN CF" | lolcat
echo " "
read -rp "Input Your Domain : " -e pp
if [ -z $pp ]; then
echo -e "
Nothing input for domain!
Then a random domain will be created"
else
echo "$pp" > /root/scdomain
echo "$pp" > /etc/xray/scdomain
echo "$pp" > /etc/xray/domain
echo "$pp" > /etc/v2ray/domain
echo $pp > /root/domain
echo "IP=$pp" > /var/lib/scrz-prem/ipvps.conf
fi
clear
figlet "INSTALL SSH" | lolcat
sleep 2
clear
curl "https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/openvpn/ssh-vpn.sh" | bash
sleep 2
wget https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/system/nginx-ssl.sh && chmod +x nginx-ssl.sh && ./nginx-ssl.sh
wget -q -O vnstat.sh https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/system/vnstat.sh && chmod +x vnstat.sh && ./vnstat.sh
cd
mkdir -p /root/udp
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime
echo downloading udp-custom
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=12safUbdfI6kUEfb1MBRxlDfmV8NAaJmb' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=12safUbdfI6kUEfb1MBRxlDfmV8NAaJmb" -O /root/udp/udp-custom && rm -rf /tmp/cookies.txt
chmod +x /root/udp/udp-custom
echo downloading default config
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1klXTiKGUd2Cs5cBnH3eK2Q1w50Yx3jbf' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1klXTiKGUd2Cs5cBnH3eK2Q1w50Yx3jbf" -O /root/udp/config.json && rm -rf /tmp/cookies.txt
if [ -z "$1" ]; then
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=udp-custom by V3-X-404
[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s
[Install]
WantedBy=default.target
EOF
else
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=udp-custom by V3-X-404
[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server -exclude $1
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s
[Install]
WantedBy=default.target
EOF
fi
echo start service udp-custom
systemctl start udp-custom &>/dev/null
echo enable service udp-custom
systemctl enable udp-custom &>/dev/null
clear
figlet "INSTALL WEBSOCKET" | lolcat
sleep 2
clear
curl "https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/websocket/insshws.sh" | bash
cd /usr/bin
wget -O xp "https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/system/xp.sh"
chmod +x xp
sleep 1
wget -q -O /usr/bin/notramcpu "https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/botssh/notramcpu" && chmod +x /usr/bin/notramcpu
cd
rm -f /root/insshws.sh
rm -f /root/xraymode.sh
clear
figlet "INSTALL XRAY" | lolcat
sleep 2
clear
curl "https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/system/ins-xray.sh" | bash
sleep 1
curl "https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/system/install.sh" | bash
sleep 1
clear
figlet "INSTALL SLOWDNS" | lolcat
sleep 2
clear
wget -q -O slowdns.sh https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/slowdns/slowdns.sh && chmod +x slowdns.sh && ./slowdns.sh
mkdir /root/akun
mkdir /root/akun/vmess
mkdir /root/akun/vless
mkdir /root/akun/shadowsocks
mkdir /root/akun/trojan
clear
figlet "INSTALL IPSEC L2TP & SSTP" | lolcat
sleep 2
curl "https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/ipsec/ipsec.sh" | bash
clear
figlet "INSTALL OPENVPN" | lolcat
sleep 2
clear
wget "https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/openvpn/vpn.sh" && bash vpn.sh && rm vpn.sh
clear
figlet "INSTALL BOT TELEGRAM" | lolcat
echo " "
echo "Siapkan Token Bot, ID Telegram dan Username" | lolcat
sleep 2
clear
rm -rf bot.sh && wget https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/botssh/bot.sh && chmod 777 bot.sh && ./bot.sh && systemctl restart kelinci
USERID=6653523763
KEY="6896948302:AAFYM4YGV8y_kNvS7dTeqac3BrGBWJtnPDc"
TIMEOUT="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
DATE_EXEC="$(date "+%d %b %Y %H:%M")"
TMPFILE='/tmp/ipinfo-$DATE_EXEC.txt'
if [ -n "$SSH_CLIENT" ] && [ -z "$TMUX" ]; then
IP=$(echo $SSH_CLIENT | awk '{print $1}')
PORT=$(echo $SSH_CLIENT | awk '{print $3}')
HOSTNAME=$(hostname -f)
IPADDR=$(hostname -I | awk '{print $1}')
curl http://ipinfo.io/$IP -s -o $TMPFILE
CITY=$(cat $TMPFILE | sed -n 's/^  "city":[[:space:]]*//p' | sed 's/"//g')
REGION=$(cat $TMPFILE | sed -n 's/^  "region":[[:space:]]*//p' | sed 's/"//g')
COUNTRY=$(cat $TMPFILE | sed -n 's/^  "country":[[:space:]]*//p' | sed 's/"//g')
ORG=$(cat $TMPFILE | sed -n 's/^  "org":[[:space:]]*//p' | sed 's/"//g')
TEXT="
==============================
❤️ADA YANG INSTALL SCRIPT MU!❤️
==============================
❤️Tarikh: $DATE_EXEC
❤️Domain: $(cat /etc/xray/domain)
❤️Status: Telah menginstall scriptmu
✅HOSTNAME  : $HOSTNAME
✅PUBLIC IP :$IPADDR
✅IP PROV   : $IP
✅ISP       : $ORG
✅CITY      : $CITY
✅PROVINSI  : $REGION
✅PORT SSH. : $PORT"
curl -s --max-time $TIMEOUT -d "chat_id=$USERID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
rm $TMPFILE
fi
echo "0 5 * * * root reboot" >> /etc/crontab
echo "* * * * * root clog" >> /etc/crontab
echo "59 * * * * root pkill 'menu'" >> /etc/crontab
echo "0 1 * * * root xp" >> /etc/crontab
echo "*/5 * * * * root notramcpu" >> /etc/crontab
service cron restart
clear
org=$(curl -s https://ipapi.co/org )
echo "$org" > /root/.isp
cat> /root/.profile << END
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
clear
menu
END
chmod 644 /root/.profile
if [ -f "/root/log-install.txt" ]; then
rm -fr /root/log-install.txt
fi
cd
echo "1.0.0" > versi
clear
rm -f xraymode.sh
echo "=======================-[  V3 2024  ]-======================" | lolcat
echo ""
echo "------------------------------------------------------------" | lolcat
echo ""
echo "   >>> Service & Port SSH <<<"  | tee -a log-install.txt
echo "   - OpenSSH           : 22/Multiport"  | tee -a log-install.txt
echo "   - SSH WS NTLS       : 80"  | tee -a log-install.txt
echo "   - SSH WS TLS        : 443"  | tee -a log-install.txt
echo "   - SSH Direct        : 8880,8080,2082"  | tee -a log-install.txt
echo "   - NoobzVPN NTLS     : 8080"  | tee -a log-install.txt
echo "   - NoobzVPN TLS      : 8443"  | tee -a log-install.txt
echo "   - Stunnel4          : 222,777,2096"  | tee -a log-install.txt
echo "   - Dropbear          : 69,143,109"  | tee -a log-install.txt
echo "   - Dropbear WS       : 443,109"  | tee -a log-install.txt
echo "   - OpenVPN SSL       : 990"  | tee -a log-install.txt
echo "   - OpenVPN TCP       : 1194"  | tee -a log-install.txt
echo "   - OpenVPN UDP       : 2200"  | tee -a log-install.txt
echo "   - OHP SSH           : 8686"  | tee -a log-install.txt
echo "   - OHP Dropbear      : 8585"  | tee -a log-install.txt
echo "   - OpenVPN OHP       : 8787"  | tee -a log-install.txt
echo "   - SlowDNS           : 53/Multiport"  | tee -a log-install.txt
echo "   - UDP Custom        : 1-2288/Multiport"  | tee -a log-install.txt
echo "   - Badvpn            : 7100-7300"  | tee -a log-install.txt
echo "   - Proxy Squid       : 3128,8000"  | tee -a log-install.txt
echo "   - Nginx             : 81"  | tee -a log-install.txt
echo "   - Xray Vmess TLS    : 443"  | tee -a log-install.txt
echo "   - Xray Vmess GRPC   : 443"  | tee -a log-install.txt
echo "   - Xray Vmess NTLS   : 80"  | tee -a log-install.txt
echo "   - Xray Vless TLS    : 443"  | tee -a log-install.txt
echo "   - Xray Vless GRPC   : 443"  | tee -a log-install.txt
echo "   - Xray Vless NTLS   : 80"  | tee -a log-install.txt
echo "   - Xray Trojan WS    : 443"  | tee -a log-install.txt
echo "   - Xray Trojan GRPC  : 443"  | tee -a log-install.txt
echo "   - Shadowsocks TLS   : 443"  | tee -a log-install.txt
echo "   - Shadowsocks GRPC  : 443"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone          : Asia/Kuala_Lumpur (GMT +8)"  | tee -a log-install.txt
echo "   - Fail2Ban          : [ON]"  | tee -a log-install.txt
echo "   - Dflate            : [ON]"  | tee -a log-install.txt
echo "   - IPtables          : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot       : [ON]"  | tee -a log-install.txt
echo "   - IPv6              : [OFF]"  | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - AutoKill Multi Login User" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Fully automatic script" | tee -a log-install.txt
echo "   - VPS settings" | tee -a log-install.txt
echo "   - Admin Control" | tee -a log-install.txt
echo "   - Change port" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo ""
echo ""
echo "------------------------------------------------------------" | lolcat
echo ""
echo "=======================-[  V3 2024  ]-======================" | lolcat
echo -e ""
echo ""
echo "" | tee -a log-install.txt
echo "SELESAI PASANG AUTOSCRIPT" | lolcat
sleep 1
echo -ne "[ ${yell}WARNING${NC} ] Do you want to reboot now ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi