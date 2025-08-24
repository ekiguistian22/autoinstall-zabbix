#!/bin/bash
# ============================================================
# Zabbix 7.4 Auto Installer (Ubuntu 22.04 + MySQL + Nginx)
# Author : Eki Guistian
# ============================================================

# --- Root Check ---
if [[ $EUID -ne 0 ]]; then
   echo "❌ Script ini harus dijalankan sebagai root (sudo -s)"
   exit 1
fi

echo "=== Zabbix 7.4 Installer ==="
read -p "Masukkan password untuk user MySQL zabbix: " ZABBIX_DB_PASS
read -p "Masukkan domain/server_name untuk Nginx (contoh: monitoring.example.com): " ZABBIX_DOMAIN

# --- Install Repo ---
echo "📦 Menambahkan repository Zabbix..."
wget -q https://repo.zabbix.com/zabbix/7.4/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.4+ubuntu22.04_all.deb
dpkg -i zabbix-release_latest_7.4+ubuntu22.04_all.deb
apt update -y

# --- Install Packages ---
echo "📦 Menginstall paket Zabbix..."
apt install -y mysql-server zabbix-server-mysql zabbix-frontend-php \
  zabbix-nginx-conf zabbix-sql-scripts zabbix-agent

# --- Setup Database ---
echo "🗄️ Membuat database Zabbix..."
mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER 'zabbix'@'localhost' IDENTIFIED BY '${ZABBIX_DB_PASS}';
GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';
SET GLOBAL log_bin_trust_function_creators = 1;
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# --- Import Schema ---
echo "🗄️ Import schema awal Zabbix..."
zcat /usr/share/zabbix/sql-scripts/mysql/server.sql.gz | \
mysql --default-character-set=utf8mb4 -uzabbix -p${ZABBIX_DB_PASS} zabbix

# --- Disable log_bin_trust_function_creators ---
mysql -uroot <<MYSQL_SCRIPT
SET GLOBAL log_bin_trust_function_creators = 0;
MYSQL_SCRIPT

# --- Configure Zabbix Server ---
echo "⚙️ Mengkonfigurasi Zabbix Server..."
sed -i "s/^# DBPassword=.*/DBPassword=${ZABBIX_DB_PASS}/" /etc/zabbix/zabbix_server.conf
if ! grep -q "DBPassword=${ZABBIX_DB_PASS}" /etc/zabbix/zabbix_server.conf; then
  echo "DBPassword=${ZABBIX_DB_PASS}" >> /etc/zabbix/zabbix_server.conf
fi

# --- Configure Nginx for Zabbix ---
echo "⚙️ Konfigurasi Nginx..."
sed -i "s|# listen 8080;|listen 80;|" /etc/zabbix/nginx.conf
sed -i "s|# server_name example.com;|server_name ${ZABBIX_DOMAIN};|" /etc/zabbix/nginx.conf

# --- Restart Services ---
echo "🚀 Restarting services..."
systemctl restart zabbix-server zabbix-agent nginx php8.1-fpm
systemctl enable zabbix-server zabbix-agent nginx php8.1-fpm

echo "✅ Instalasi Zabbix selesai!"
echo "Akses Zabbix Web UI di: http://${ZABBIX_DOMAIN}/"
echo "Login default: Admin / zabbix"
