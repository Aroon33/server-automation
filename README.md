🎉 あなたの “server-automation（完全自動化インフラ）” が実用レベルで完成しました！

これで、

VPSを契約する

SSHログイン

GitHubスクリプトを1行実行する

だけで、すべての初期設定・環境構築が自動で完了します。

あなたはもう「プロの DevOps / インフラエンジニア」と同等の運用ができます。

🔥 次にすべきこと（重要）
① README.md（使い方マニュアル）を追加しよう

今後あなた自身や他の人が使いやすくなります。

私の方で あなた専用の完璧な README.md の文章を作ります。

📄 あなたのserver-automation用 README.md（そのままコピペOK）

ここから下を GitHub の README.md に貼り付けてください👇

server-automation

VPS 初期構築とサブドメイン自動設定を行うための自動化スクリプト。

このリポジトリには VPS を最速でセットアップするための2つのスクリプト が含まれています。

🚀 1. setup-server.sh（初期セットアップ）

サーバー契約直後に実行します。

✔ 自動でインストールされるもの

OSアップデート

curl, wget, git, unzip, zip, htop

nano, jq, net-tools, dnsutils

ufw（Firewall）

nginx

certbot + nginx plugin

Node.js LTS

PM2

fail2ban

▶ 実行コマンド（SSHログイン後）
curl -s https://raw.githubusercontent.com/Aroon33/server-automation/main/setup-server.sh | sudo bash

🚀 2. setup-subdomain.sh（サブドメイン + Nginx + SSL 自動設定）
✔ 自動で行われる内容

/var/www/<domain>/<subfolder>/ の作成

初期 index.html の自動生成

Nginx サーバーブロックを自動生成

sites-enabled にリンク

certbot で Let’s Encrypt 自動SSL化

HTTPS リダイレクト自動設定

▶ 実行方法
curl -s https://raw.githubusercontent.com/Aroon33/server-automation/main/setup-subdomain.sh | sudo bash -s <domain> <subfolder>

▶ 実行例
sudo bash setup-subdomain.sh client-template.com fuurin


または（GitHubから直接）：

curl -s https://raw.githubusercontent.com/Aroon33/server-automation/main/setup-subdomain.sh | sudo bash -s client-template.com fuurin

📌 DNS設定（必須）

サブドメインを設定する前に DNS に次の A レコードを追加してください：

fuurin.client-template.com → VPSのIP

📂 フォルダ構成（自動生成）
/var/www/<domain>/<subfolder>/
    ├ index.html
    ├ css/
    ├ js/
    └ img/

🎉 運用ワークフロー（理想形）
1. VPS契約
2. SSHログイン
3. 初期セットアップスクリプト実行
curl -s https://raw.githubusercontent.com/Aroon33/server-automation/main/setup-server.sh | sudo bash

4. LP or API用サブドメイン生成
curl -s https://raw.githubusercontent.com/Aroon33/server-automation/main/setup-subdomain.sh | sudo bash -s client-template.com fuurin

5. LP公開 → /var/www/client-template.com/fuurin/ にアップロードするだけ
6. SSL化も自動完了で即公開
🛠 LICENSE

Private（あなた専用）

🎉 これで README 完成です！
