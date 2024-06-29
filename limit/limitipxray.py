import os
import subprocess
import time

def process_user_protocol(protocol):
    subprocess.run(["sudo", "rm", "/var/log/xray/access.log"])
    subprocess.run(["sudo", "rm", "-f", "/var/log/xray/access.log"])
    subprocess.run(["systemctl", "restart", "xray"])
    time.sleep(30)
    subprocess.run(["rm", "-f", "/root/limit/*"])
    time.sleep(1)
    with open('/etc/xray/config.json') as f:
        data = [line.split()[1] for line in f if line.startswith(f'#{protocol}') and len(line.split()) >= 2]
        for user in data:
            nilai = int(open(f"/etc/kelinci/limit/{protocol}/ip/{user}").read())
            limitxray = nilai + 1
            
            # Check if folder exists, if not, create it
            if not os.path.exists(f"/root/limit/{user}"):
                os.makedirs(f"/root/limit/{user}")
            
            subprocess.run(["bash", "-c", f"cat /var/log/xray/access.log | grep {user} | awk '{{print $3}}' | sed 's/tcp://g' | sed 's/:0//g' | sort | uniq > /root/limit/{user}"])
            jumlahdata = subprocess.run(["wc", "-l", f"/root/limit/{user}"], capture_output=True, text=True).stdout
            jumlahdata = int(jumlahdata.strip().split()[0])
            if jumlahdata > limitxray:
                kirimtele = f" MULTI LOGIN DETECTED {user} login {jumlahdata} IP"
                with open("/root/limit/rulesxray.txt", "a") as rules_file:
                    rules_file.write(f"#{protocol} {kirimtele}\n")
                with open("/root/kelinci/var.txt") as var_file:
                    BOT_TOKEN = var_file.readline().strip()
                    ADMIN = var_file.readline().strip()
                subprocess.run(["curl", "-s", "-X", "POST", f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage", "-d", f"chat_id={ADMIN}", "-d", f"text={kirimtele}"])
                exp = open('/etc/xray/config.json').read()
                exp = exp.split(f"#{protocol} {user} ")[-1].split('},')[0]
                subprocess.run(["sed", "-i", f"/^#{protocol} {user} {exp}/,/^}},{{/d", "/etc/xray/config.json"])
                subprocess.run(["systemctl", "restart", "xray"])
                subprocess.run(["rm", "-f", "/root/limit/*"])
                subprocess.run(["rm", "-f", f"/root/limit/{user}"])
            else:
                print("aman")
                subprocess.run(["rm", "-f", "/root/limit/*"])

def vmess():
    process_user_protocol("vmess")

def vless():
    process_user_protocol("vless")

def trojan():
    process_user_protocol("trojan")

vmess()
vless()
trojan()

