# 🚀 Zabbix 7.4 Installer  
*(Ubuntu 22.04 + MySQL + Nginx)*

![Zabbix Logo](https://assets.zabbix.com/img/logo/zabbix_logo_500x131.png)

[![Zabbix](https://img.shields.io/badge/Zabbix-7.4-red?logo=zabbix)](https://www.zabbix.com/)  
[![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04-orange?logo=ubuntu)](https://ubuntu.com/)  
[![Bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg?logo=gnu-bash)](https://www.gnu.org/software/bash/)  

---

Script ini digunakan untuk menginstal **Zabbix 7.4** secara otomatis di Ubuntu 22.04, lengkap dengan **MySQL** sebagai database dan **Nginx** sebagai web server.  

This script installs **Zabbix 7.4** automatically on Ubuntu 22.04, with **MySQL** as the database and **Nginx** as the web server.

---

## ✨ Fitur / Features
- ⚡ Instalasi otomatis Zabbix 7.4 (server, frontend, agent)  
  ⚡ Automatic installation of Zabbix 7.4 (server, frontend, agent)  
- 🗄️ Konfigurasi database MySQL (`zabbix` user & database)  
  🗄️ Configures MySQL database (`zabbix` user & database)  
- 📥 Import schema awal Zabbix otomatis  
  📥 Automatic initial schema import  
- 🌐 Konfigurasi Nginx + PHP-FPM  
  🌐 Configures Nginx + PHP-FPM  
- 🔐 Konfigurasi password database di `zabbix_server.conf`  
  🔐 Sets DB password in `zabbix_server.conf`  
- 👨‍💻 Interaktif → tanya password, domain, dan port saat instalasi  
  👨‍💻 Interactive → asks password, domain, and port during installation  

---

## 📋 Prasyarat / Requirements
- 🖥️ Server dengan **Ubuntu 22.04 LTS**  
  🖥️ Server running **Ubuntu 22.04 LTS**  
- 🔑 Akses root (`sudo`)  
  🔑 Root access (`sudo`)  
- 🌍 Koneksi internet  
  🌍 Internet connection  

---

## ⚙️ Cara Instalasi / Installation Steps

### 1️⃣ Download script
```bash
git clone https://github.com/ekiguistian22/autoinstall-zabbix
cd autoinstall-zabbix
chmod +x install.sh
```

### 2️⃣ Jalankan script sebagai root / Run script as root
```bash
bash install.sh
```

### 3️⃣ Ikuti prompt / Follow the prompts
- Masukkan **password MySQL** untuk user `zabbix`  
  Enter **MySQL password** for `zabbix` user  
- Masukkan **domain/server_name** (contoh: `monitoring.example.com`)  
  Enter **domain/server_name** (e.g., `monitoring.example.com`)  
- Masukkan **port Nginx** (default `80`)  
  Enter **Nginx port** (default `80`)  

⚡ Script akan otomatis:  
⚡ The script will automatically:  
- Install semua paket yang dibutuhkan / Install all required packages  
- Setup database Zabbix / Setup Zabbix database  
- Import schema default / Import default schema  
- Konfigurasi Zabbix server dan Nginx / Configure Zabbix server and Nginx  
- Restart service / Restart services  

---

## 🌐 Akses Web UI / Access Web UI

Setelah instalasi selesai, buka di browser:  
After installation, open in browser:  

```
http://DOMAIN_ANDA:PORT/
http://YOUR_DOMAIN:PORT/
```

Contoh / Example:  
```
http://monitoring.example.com/
```

### 🔑 Login Default
- **Username:** `Admin`  
- **Password:** `zabbix`  

---

## 🛠️ Services yang dijalankan / Services enabled
✅ `zabbix-server`  
✅ `zabbix-agent`  
✅ `nginx`  
✅ `php8.1-fpm`  
✅ `mysql`  

Semua service otomatis berjalan saat booting.  
All services enabled to start on boot.  

---

## 📌 Catatan / Notes
- 🔥 Pastikan **firewall** membuka port sesuai yang Anda pilih (`80` atau custom).  
  🔥 Make sure **firewall** allows the chosen port (`80` or custom).  
- 🔐 Ubah password default `Admin / zabbix` setelah login pertama.  
  🔐 Change default `Admin / zabbix` password after first login.  
- 🌍 Untuk domain publik, pastikan DNS diarahkan ke server.  
  🌍 For public domain, ensure DNS points to the server.  

---

✍️ **Author / Penulis:** Eki Guistian  
📅 Versi / Version: 1.0  
