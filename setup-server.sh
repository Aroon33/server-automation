#!/bin/bash

echo "============================================"
echo "   サーバー初期構築スクリプト開始"
echo "============================================"

# ------ OS UPDATE ------
echo "[1/8] OSアップデート中..."
apt update -y && apt upgrade -y


# ------ BASIC PACKAGES ------
echo "[2/8] 基本パッケージをインストール..."
apt install -y curl wget git unzip zip htop nano jq net-tools dnsutils software-properties-common


# ------ FIREWALL (UFW) ------
echo "[3/8] UFW（ファイアウォール）設定..."
apt install -y ufw
ufw allow OpenSSH
ufw allow 'Nginx Full'
ufw --force enable


# ------ NGINX ------
echo "[4/8] Nginx インストール..."
apt install -y nginx
systemctl enable nginx
systemctl start nginx


# ------ CERTBOT (Let's Encrypt) ------
echo "[5/8] Certbot（SSL）をインストール..."
apt install -y certbot python3-certbot-nginx


# ------ NODE.JS (LTS) ------
echo "[6/8] Node.js LTS をインストール..."
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

echo "Node.js バージョン: $(node -v)"
echo "npm バージョン: $(npm -v)"


# ------ PM2 (Node Process Manager) ------
echo "[7/8] PM2 をグローバルインストール..."
npm install -g pm2
pm2 startup systemd -u root --hp /root >/dev/null 2>&1


# ------ SECURITY: FAIL2BAN ------
echo "[8/8] fail2ban をインストール..."
apt install -y fail2ban
systemctl enable fail2ban
systemctl start fail2ban


echo "============================================"
echo "   初期セットアップ完了！"
echo "============================================"
echo " 次に行うこと："
echo "--------------------------------------------"
echo " ① ドメインのDNS設定 (Aレコード → VPSのIP)"
echo " ② setup-subdomain.sh を実行して、"
echo "    サブドメイン + Nginx + SSL を自動構築"
echo "--------------------------------------------"
echo " 例:"
echo "   ./setup-subdomain.sh client-template.com fuurin"
echo "--------------------------------------------"
echo "お疲れさまでした！"
echo "============================================"
