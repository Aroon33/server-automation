#!/bin/bash

###############################
# 使い方:
# ./setup-subdomain.sh example.com subfolder
###############################

# --- 引数チェック ---
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "使用方法: ./setup-subdomain.sh <ドメイン> <サブフォルダ名>"
    echo "例: ./setup-subdomain.sh client-template.com fuurin"
    exit 1
fi

DOMAIN="$1"
SUB="$2"
SUBDOMAIN="${SUB}.${DOMAIN}"
WEBROOT="/var/www/${DOMAIN}/${SUB}"

echo "===================================="
echo " ドメイン: ${DOMAIN}"
echo " サブドメイン: ${SUBDOMAIN}"
echo " Webルート: ${WEBROOT}"
echo "===================================="

# --- ディレクトリ作成 ---
echo "[1/6] プロジェクトディレクトリ作成..."
mkdir -p ${WEBROOT}
mkdir -p ${WEBROOT}/css
mkdir -p ${WEBROOT}/img
mkdir -p ${WEBROOT}/js

# 初期 index.html
cat <<EOF > ${WEBROOT}/index.html
<!DOCTYPE html>
<html lang="ja">
<head><meta charset="utf-8"><title>${SUBDOMAIN}</title></head>
<body>
<h1>${SUBDOMAIN} セットアップ成功</h1>
<p>このページは自動生成されました。</p>
</body>
</html>
EOF

# 権限
chown -R www-data:www-data /var/www/${DOMAIN}

# --- Nginx 設定ファイル作成 ---
echo "[2/6] Nginx サーバーブロック作成..."
NGINX_CONF="/etc/nginx/sites-available/${SUBDOMAIN}"

cat <<EOF > ${NGINX_CONF}
server {
    listen 80;
    server_name ${SUBDOMAIN};

    root ${WEBROOT};
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# enable
ln -s ${NGINX_CONF} /etc/nginx/sites-enabled/${SUBDOMAIN} 2>/dev/null

# Nginx チェック & reload
echo "[3/6] Nginx 設定チェック"
nginx -t
if [ $? -ne 0 ]; then
    echo "Nginx設定エラー。修正してください。"
    exit 1
fi

echo "[4/6] Nginx 再起動..."
systemctl restart nginx

# --- SSL セットアップ ---
echo "[5/6] Certbot を実行して SSL 化します..."
certbot --nginx -d ${SUBDOMAIN} --non-interactive --agree-tos -m admin@${DOMAIN} --redirect

echo "[6/6] 完了！"
echo "===================================="
echo "アクセスURL: https://${SUBDOMAIN}"
echo "===================================="
