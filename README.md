<div align="center">

# 🖥️ VPS Reinstall Script
### by Hanief Autophile

![Bash](https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![OpenSSL](https://img.shields.io/badge/Encrypt-AES--256--CBC-721412?style=for-the-badge&logo=openssl&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

> Script reinstall VPS otomatis dengan dukungan multi OS.  
> Isi script terenkripsi — aman dari modifikasi tanpa izin.

</div>

---

## 🚀 How to Install

```bash
git clone https://github.com/haniefautophile-official/reinstall-vps.git && cd reinstall-vps && chmod +x run.sh && bash run.sh
```

---

## 🖥️ OS System

```
╔══════════════════════════════════════════════════════════╗
║                   PILIH OS TARGET                        ║
╚══════════════════════════════════════════════════════════╝

  No.  OS                       No.  OS
  ────────────────────────────────────────────────────────
  [1]  Ubuntu                   [6]  Fedora
  [2]  Debian                   [7]  openSUSE
  [3]  CentOS                   [8]  Alpine Linux
  [4]  AlmaLinux                [9]  Kali Linux
  [5]  Rocky Linux              [0]  Keluar
  ────────────────────────────────────────────────────────
```

---

## 📋 OS & Versi yang Didukung

| OS | Versi |
|---|---|
| **Ubuntu** | 18.04 / 20.04 / 22.04 / 24.04 LTS |
| **Debian** | 9 / 10 / 11 / 12 |
| **CentOS** | 7 / Stream 8 / Stream 9 |
| **AlmaLinux** | 8.x / 9.x |
| **Rocky Linux** | 8.x / 9.x |
| **Fedora** | 38 / 39 / 40 |
| **openSUSE** | Leap 15.4 / 15.5 / Tumbleweed |
| **Alpine Linux** | 3.17 / 3.18 / 3.19 |
| **Kali Linux** | Rolling (latest) |

---

## ⚙️ Requirements

- VPS dengan akses **root**
- Koneksi internet aktif
- OS: Debian / Ubuntu / CentOS (OS awal sebelum reinstall)

```bash
# Pastikan tools berikut tersedia (auto-install jika belum ada)
wget  curl  openssl
```

---

## ⚠️ Peringatan

> **SEMUA DATA AKAN TERHAPUS PERMANEN saat reinstall dijalankan.**  
> Pastikan sudah backup data penting sebelum melanjutkan.

Script akan meminta konfirmasi `YES` sebelum proses dimulai,  
dan konfirmasi `y/n` sebelum server reboot.

---

## 📁 Struktur Repo

```
reinstall-vps/
├── run.sh          # Entry point (terenkripsi)
└── README.md       # Dokumentasi ini
```

---

## 📜 License

MIT License © [Hanief Autophile](https://github.com/haniefautophile-official)

---

<div align="center">
  <sub>Made with ❤️ by Hanief Autophile</sub>
</div>
