#!/bin/bash

echo "========================================="
echo " ConoHa 専用サーバー初期構築（安定版）開始"
echo "========================================="

# ---- OS update（upgrade は行わない） ----
apt update -y

# ---- 基本パッケージ ----
apt install -y curl wget git unzip zip htop nano jq net-tools dnsutils

# ---- Firewall ----
apt install -y ufw
ufw allow OpenSSH
ufw allow 'Nginx Full'
ufw --force enable

# ---- Nginx ----
apt install -y nginx
systemctl enable nginx
systemctl start nginx

# ---- Certbot ----
apt install -y certbot python3-certbot-nginx

# ---- Node.js 20 LTS ----
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

# ---- PM2 ----
npm install -g pm2
pm2 startup systemd -u root --hp /root >/dev/null 2>&1

# ---- fail2ban ----
apt install -y fail2ban
systemctl enable fail2ban
systemctl start fail2ban

echo "========================================="
echo " ConoHa 初期構築 完了！"
echo "========================================="
echo " 次に以下コマンドを実行してください:"
echo "   curl -s https://raw.githubusercontent.com/Aroon33/server-automation/main/setup-subdomain.sh | bash -s <domain> <subfolder>"
echo "========================================="
