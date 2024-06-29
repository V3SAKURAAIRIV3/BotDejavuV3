#!/bin/bash
# ======================================
# Autoscript Modded By SakuraV3 2024
# ======================================

# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ipinfo.io/ip);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

#detail nama perusahaan
country=MY
state=Selangor
locality=Kuala_Lumpur
organization=Anonymous
organizationalunit=Anonymous
commonname=Anonymous
email=admin@anonymous.com

# simple password minimal
wget -O /etc/pam.d/common-password "https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/websocket/password.txt"
chmod +x /etc/pam.d/common-password

sudo apt install iptables-persistent netfilter-persistent
# go to root
cd

# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#update
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y

#install jq
apt -y install jq
apt install sysstat -y

#install shc
apt -y install shc

# install wget and curl
apt -y install wget curl

#figlet
apt-get install figlet -y
apt-get install ruby -y
gem install lolcat

# set time GMT +8
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config


install_ssl(){
    if [ -f "/usr/bin/apt-get" ];then
            isDebian=`cat /etc/issue|grep Debian`
            if [ "$isDebian" != "" ];then
                    apt-get install -y nginx certbot
                    apt install -y nginx certbot
                    sleep 3s
            else
                    apt-get install -y nginx certbot
                    apt install -y nginx certbot
                    sleep 3s
            fi
    else
        yum install -y nginx certbot
        sleep 3s
    fi

    systemctl stop nginx.service

    if [ -f "/usr/bin/apt-get" ];then
            isDebian=`cat /etc/issue|grep Debian`
            if [ "$isDebian" != "" ];then
                    echo "A" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
                    sleep 3s
            else
                    echo "A" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
                    sleep 3s
            fi
    else
        echo "Y" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
        sleep 3s
    fi
}

# install webserver
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/system/nginx.conf"
mkdir -p /home/vps/public_html
/etc/init.d/nginx restart

# install badvpn
cd
cd
wget -O /usr/bin/badvpn-udpgw https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/udp/badvpn-udpgw && chmod +x  /usr/bin/badvpn-udpgw
#system badvpn 7300
wget -O /etc/systemd/system/svr-7300.service https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/udp/svr-7300.service && chmod +x  /etc/systemd/system/svr-7300.service
#system badvpn 7200
wget -O /etc/systemd/system/svr-7200.service https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/udp/svr-7200.service && chmod +x  /etc/systemd/system/svr-7200.service
#system badvpn 7100
wget -O /etc/systemd/system/svr-7100.service https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/udp/svr-7100.service && chmod +x  /etc/systemd/system/svr-7100.service

#reboot system 7100
systemctl daemon-reload
systemctl start svr-7100.service
systemctl enable svr-7100.service
systemctl restart svr-7100.service

#reboot system 7200
systemctl daemon-reload
systemctl start svr-7200.service
systemctl enable svr-7200.service
systemctl restart svr-7200.service

#reboot system 7300
systemctl daemon-reload
systemctl start svr-7300.service
systemctl enable svr-7300.service
systemctl restart svr-7300.service

# setting port ssh
cd
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g'
# /etc/ssh/sshd_config
sed -i '/Port 22/a Port 500' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 51443' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 58080' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 200' /etc/ssh/sshd_config
sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
/etc/init.d/ssh restart

echo "=== Install Dropbear ==="
# install dropbear
apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 50000 -p 109 -p 110 -p 69"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/ssh restart
/etc/init.d/dropbear restart

cd
# install stunnel
apt install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 222
connect = 127.0.0.1:22

[dropbear]
accept = 777
connect = 127.0.0.1:109

[ws-stunnel]
accept = 2096
connect = 700

[openvpn]
accept = 442
connect = 127.0.0.1:1194

END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart


# install fail2ban
apt -y install fail2ban

# Instal DDOS Flate
sudo apt install dnsutils -y
sudo apt-get install net-tools -y
sudo apt-get install tcpdump -y
sudo apt-get install dsniff -y
sudo apt install grepcidr -y

clear
echo "Installation DDoS protection" | lolcat
wget https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/system/rules.zip
unzip rules.zip

# Check if the script is executed as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please execute this script as root."
    exit 1
fi

# Check for required dependencies
if [ -f "/usr/bin/apt-get" ]; then
    install_type='2';
    install_command="apt-get"
elif [ -f "/usr/bin/yum" ]; then
    install_type='3';
    install_command="yum"
elif [ -f "/usr/sbin/pkg" ]; then
    install_type='4';
    install_command="pkg"
else
    install_type='0'
fi

packages='nslookup netstat ss ifconfig tcpdump tcpkill timeout awk sed grep grepcidr'

if  [ "$install_type" = '4' ]; then
    packages="$packages ipfw"
else
    packages="$packages iptables"
fi

for dependency in $packages; do
    is_installed=`which $dependency`
    if [ "$is_installed" = "" ]; then
        echo "error: Required dependency '$dependency' is missing."
        if [ "$install_type" = '0' ]; then
            exit 1
        else
            echo -n "Autoinstall dependencies by '$install_command'? (n to exit) "
        fi
        read install_sign
        if [ "$install_sign" = 'N' -o "$install_sign" = 'n' ]; then
           exit 1
        fi
        eval "$install_command install -y $(grep $dependency config/dependencies.list | awk '{print $'$install_type'}')"
    fi
done

if [ -d "$DESTDIR/usr/local/ddos" ]; then
    echo "Please un-install the previous version first"
    exit 0
else
    mkdir -p "$DESTDIR/usr/local/ddos"
fi

clear

if [ ! -d "$DESTDIR/etc/ddos" ]; then
    mkdir -p "$DESTDIR/etc/ddos"
fi

if [ ! -d "$DESTDIR/var/lib/ddos" ]; then
    mkdir -p "$DESTDIR/var/lib/ddos"
fi

echo; echo 'Installing DDOS-protevtion v.10 by V3-X-404'; echo

if [ ! -e "$DESTDIR/etc/ddos/ddos.conf" ]; then
    echo -n 'Adding: /etc/ddos/ddos.conf...'
    cp config/ddos.conf "$DESTDIR/etc/ddos/ddos.conf" > /dev/null 2>&1
    echo " (done)"
fi

if [ ! -e "$DESTDIR/etc/ddos/ignore.ip.list" ]; then
    echo -n 'Adding: /etc/ddos/ignore.ip.list...'
    cp config/ignore.ip.list "$DESTDIR/etc/ddos/ignore.ip.list" > /dev/null 2>&1
    echo " (done)"
fi

if [ ! -e "$DESTDIR/etc/ddos/ignore.host.list" ]; then
    echo -n 'Adding: /etc/ddos/ignore.host.list...'
    cp config/ignore.host.list "$DESTDIR/etc/ddos/ignore.host.list" > /dev/null 2>&1
    echo " (done)"
fi

echo -n 'Adding: /usr/local/ddos/LICENSE...'
cp LICENSE "$DESTDIR/usr/local/ddos/LICENSE" > /dev/null 2>&1
echo " (done)"

echo -n 'Adding: /usr/local/ddos/ddos.sh...'
cp src/ddos.sh "$DESTDIR/usr/local/ddos/ddos.sh" > /dev/null 2>&1
chmod 0755 /usr/local/ddos/ddos.sh > /dev/null 2>&1
echo " (done)"

echo -n 'Creating ddos script: /usr/local/sbin/ddos...'
mkdir -p "$DESTDIR/usr/local/sbin/"
echo "#!/bin/sh" > "$DESTDIR/usr/local/sbin/ddos"
echo "/usr/local/ddos/ddos.sh \$@" >> "$DESTDIR/usr/local/sbin/ddos"
chmod 0755 "$DESTDIR/usr/local/sbin/ddos"
echo " (done)"

echo -n 'Adding man page...'
mkdir -p "$DESTDIR/usr/share/man/man1/"
cp man/ddos.1 "$DESTDIR/usr/share/man/man1/ddos.1" > /dev/null 2>&1
chmod 0644 "$DESTDIR/usr/share/man/man1/ddos.1" > /dev/null 2>&1
echo " (done)"

if [ -d /etc/logrotate.d ]; then
    echo -n 'Adding logrotate configuration...'
    mkdir -p "$DESTDIR/etc/logrotate.d/"
    cp src/ddos.logrotate "$DESTDIR/etc/logrotate.d/ddos" > /dev/null 2>&1
    chmod 0644 "$DESTDIR/etc/logrotate.d/ddos"
    echo " (done)"
fi

echo;

if [ -d /etc/newsyslog.conf.d ]; then
    echo -n 'Adding newsyslog configuration...'
    mkdir -p "$DESTDIR/etc/newsyslog.conf.d"
    cp src/ddos.newsyslog "$DESTDIR/etc/newsyslog.conf.d/ddos" > /dev/null 2>&1
    chmod 0644 "$DESTDIR/etc/newsyslog.conf.d/ddos"
    echo " (done)"
fi

echo;

if [ -d /lib/systemd/system ]; then
    echo -n 'Setting up systemd service...'
    mkdir -p "$DESTDIR/lib/systemd/system/"
    cp src/ddos.service "$DESTDIR/lib/systemd/system/" > /dev/null 2>&1
    chmod 0644 "$DESTDIR/lib/systemd/system/ddos.service" > /dev/null 2>&1
    echo " (done)"

    # Check if systemctl is installed and activate service
    SYSTEMCTL_PATH=`whereis systemctl`
    if [ "$SYSTEMCTL_PATH" != "systemctl:" ] && [ "$DESTDIR" = "" ]; then
        echo -n "Activating ddos service..."
        systemctl enable ddos > /dev/null 2>&1
        systemctl start ddos > /dev/null 2>&1
        echo " (done)"
    else
        echo "ddos service needs to be manually started... (warning)"
    fi
elif [ -d /etc/init.d ]; then
    echo -n 'Setting up init script...'
    mkdir -p "$DESTDIR/etc/init.d/"
    cp src/ddos.initd "$DESTDIR/etc/init.d/ddos" > /dev/null 2>&1
    chmod 0755 "$DESTDIR/etc/init.d/ddos" > /dev/null 2>&1
    echo " (done)"

    # Check if update-rc is installed and activate service
    UPDATERC_PATH=`whereis update-rc.d`
    if [ "$UPDATERC_PATH" != "update-rc.d:" ] && [ "$DESTDIR" = "" ]; then
        echo -n "Activating ddos service..."
        update-rc.d ddos defaults > /dev/null 2>&1
        service ddos start > /dev/null 2>&1
        echo " (done)"
    else
        echo "ddos service needs to be manually started... (warning)"
    fi
elif [ -d /etc/rc.d ]; then
    echo -n 'Setting up rc script...'
    mkdir -p "$DESTDIR/etc/rc.d/"
    cp src/ddos.rcd "$DESTDIR/etc/rc.d/ddos" > /dev/null 2>&1
    chmod 0755 "$DESTDIR/etc/rc.d/ddos" > /dev/null 2>&1
    echo " (done)"

    # Activate the service
    echo -n "Activating ddos service..."
    echo 'ddos_enable="YES"' >> /etc/rc.conf
    service ddos start > /dev/null 2>&1
    echo " (done)"
elif [ -d /etc/cron.d ] || [ -f /etc/crontab ]; then
    echo -n 'Creating cron to run script every minute...'
    /usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
    echo " (done)"
fi

echo; echo 'Installation has completed!'
echo 'Config files are located at /etc/ddos/'
echo
echo 'Please send in your comments and/or suggestions to:'
echo 'https://github.com/jgmdev/ddos-deflate/issues'
echo 'Author https://github.com/jgmdev'
echo 'moder application https://t.me/kamixramai'

exit 0

# banner /etc/issue.net
sleep 1
echo -e "[ ${green}INFO$NC ] Settings banner"
wget -q -O /etc/issue.net "https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/update/issue.net"
chmod +x /etc/issue.net
echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear


#install bbr dan optimasi kernel
wget https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/system/bbr.sh && chmod +x bbr.sh && ./bbr.sh

# blockir torrent
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

cat > /etc/cron.hourly/xp_otm <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
3 * * * * root killall /bin/bash /usr/bin/menut
END

cat > /home/re_otm <<-END
7
END

service cron restart >/dev/null 2>&1
service cron reload >/dev/null 2>&1

# remove unnecessary files
sleep 1
echo -e "[ ${green}INFO$NC ] Clearing trash"
apt autoclean -y >/dev/null 2>&1

if dpkg -s unscd >/dev/null 2>&1; then
apt -y remove --purge unscd >/dev/null 2>&1
fi

# finishing
cd
chown -R www-data:www-data /home/vps/public_html
sleep 1
echo -e "$yell[SERVICE]$NC Restart All service SSH & OVPN"
/etc/init.d/nginx restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}✅${NC} ] Restarting nginx"
/etc/init.d/openvpn restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}✅${NC} ] Restarting cron "
/etc/init.d/ssh restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}✅${NC} ] Restarting ssh "
/etc/init.d/dropbear restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}✅${NC} ] Restarting dropbear "
/etc/init.d/fail2ban restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}✅${NC} ] Restarting fail2ban "
/etc/init.d/stunnel4 restart >/dev/null 2>&1
sleep 1
echo -e "[ ${green}✅${NC} ] Restarting stunnel4 "
/etc/init.d/vnstat restart >/dev/null 2>&1
sleep 1

screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 500
history -c
echo "unset HISTFILE" >> /etc/profile
# finihsing
clear

#installer OPH
wget https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/openvpn/ohp.sh && chmod +x ohp.sh && ./ohp.sh
#installer openvpn

apt install iptables-persistent netfilter-persistent

rm -f /etc/iptables.rules && wget -cO - https://pastebin.com/raw/7yc33jRK > /etc/iptables.rules

iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP

iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP

iptables -I INPUT -p tcp --dport 80 -m state --state NEW -m recent --set
iptables -I INPUT -p tcp --dport 80 -m state --state NEW -m recent --update --seconds 20 --hitcount 10 -j DROP


iptables -I INPUT -p tcp --dport 81 -m state --state NEW -m recent --set
iptables -I INPUT -p tcp --dport 81 -m state --state NEW -m recent --update --seconds 20 --hitcount 10 -j DROP


## blokir syn flood

iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 80 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 443 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 69 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 69 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 143 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 143 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 222 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 222 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 90 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 90 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 69 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 69 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 2222 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 2222 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8080 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 7788 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 7788 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8443 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8443 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8484 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8484 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 8777 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 8777 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 81 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 81 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 9088 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 9088 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 9080 -j ACCEPT
    iptables -I INPUT -m state --state NEW -m udp -p udp --dport 9080 -j ACCEPT
####

dpkg-reconfigure iptables-persistent

systemctl restart fail2ban

mkdir /etc/kelinci/
mkdir /etc/kelinci/limit/
mkdir /etc/kelinci/limit/vmess
mkdir /etc/kelinci/limit/trojan
mkdir /etc/kelinci/limit/vless
mkdir /etc/kelinci/limit/vmess/ip
mkdir /etc/kelinci/limit/trojan/ip
mkdir /etc/kelinci/limit/vless/ip
mkdir /tmp/vless/
mkdir /tmp/vmess/
mkdir /tmp/trojan/


clear
print_install "Memasang Backup Server"
#BackupOption
apt install rclone -y
printf "q\n" | rclone config
wget -O /root/.config/rclone/rclone.conf "https://raw.githubusercontent.com/V3SAKURAAIRIV3/BotDejavuV3/main/backup/rclone.conf"
#Install Wondershaper
cd /bin
git clone  https://github.com/magnific0/wondershaper.git
cd wondershaper
sudo make install
cd
rm -rf wondershaper
echo > /home/files
apt install msmtp-mta ca-certificates bsd-mailx -y
cat<<EOF>>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default
host smtp.gmail.com
port 587
auth on
user vpncyber673@gmail.com
from vpncyber673@gmail.com
password tiscblgjyrahfjmi 
logfile ~/.msmtp.log
EOF
chown -R www-data:www-data /etc/msmtprc

print_success "Backup Server"


rm -f /root/key.pem
rm -f /root/cert.pem
rm -f /root/ssh-vpn.sh
rm -f /root/bbr.sh

# finihsing
clear
