# ==================================================

# NISA VPN REINSTALL VPS

# ==================================================

# Author  : Hanief Autophile

# Team    : NISA VPN Premium

# Version : 8.0

# Support : Ubuntu & Debian

# Github  : https://github.com/haniefautophile-official

# ==================================================

#!/bin/bash

# Warna

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

banner() {
clear
echo -e "${CYAN}"
echo "╔══════════════════════════════════════════╗"
echo "║          REINSTALL VPS                   ║"
echo "║                                          ║"
echo "║         Author : Hanief Autophile        ║"
echo "║         Version: 8.0                     ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"
echo -e "${WHITE}Github : https://github.com/haniefautophile-official${NC}"
echo ""
}

banner

apt update -y
apt install curl wget -y

curl -O https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh

while true; do
clear
banner

echo -e "${YELLOW}[ 1 ]${NC} Debian 10"
echo -e "${YELLOW}[ 2 ]${NC} Debian 11"
echo -e "${YELLOW}[ 3 ]${NC} Debian 12"
echo -e "${YELLOW}[ 4 ]${NC} Ubuntu 20.04"
echo -e "${YELLOW}[ 5 ]${NC} Ubuntu 22.04"
echo -e "${YELLOW}[ 6 ]${NC} Ubuntu 24.04"
echo -e "${YELLOW}[ x ]${NC} Exit"
echo ""

read -p "Pilih OS : " os

case $os in
1) OS_CMD="debian 10" ;;
2) OS_CMD="debian 11" ;;
3) OS_CMD="debian 12" ;;
4) OS_CMD="ubuntu 20.04" ;;
5) OS_CMD="ubuntu 22.04" ;;
6) OS_CMD="ubuntu 24.04" ;;
x) exit ;;
*)
echo "Pilihan tidak valid"
sleep 2
continue
;;
esac

# Input password root
clear
banner
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}  OS dipilih : ${YELLOW}${OS_CMD}${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${CYAN}Masukkan password untuk user ${WHITE}root${CYAN} setelah reinstall:${NC}"
echo ""
while true; do
    read -s -p "$(echo -e "${WHITE}Password baru : ${NC}")" ROOT_PASS
    echo ""
    read -s -p "$(echo -e "${WHITE}Konfirmasi    : ${NC}")" ROOT_PASS2
    echo ""
    if [[ "$ROOT_PASS" == "$ROOT_PASS2" ]]; then
        if [[ ${#ROOT_PASS} -lt 6 ]]; then
            echo -e "${RED}Password minimal 6 karakter, coba lagi.${NC}"
            echo ""
        else
            break
        fi
    else
        echo -e "${RED}Password tidak cocok, coba lagi.${NC}"
        echo ""
    fi
done

# Konfirmasi sebelum reinstall
clear
banner
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}      KONFIRMASI REINSTALL VPS${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${WHITE}  OS       : ${YELLOW}${OS_CMD}${NC}"
echo -e "${WHITE}  Username : ${YELLOW}root${NC}"
echo -e "${WHITE}  Password : ${YELLOW}(telah diset)${NC}"
echo ""
echo -e "${RED}⚠  PERINGATAN!${NC}"
echo -e "${RED}► Semua data & konfigurasi lama akan TERHAPUS${NC}"
echo -e "${RED}► VPS akan REBOOT OTOMATIS — SSH akan terputus${NC}"
echo -e "${GREEN}► Estimasi selesai : 5-15 menit setelah reboot${NC}"
echo -e "${GREEN}► Login kembali dengan password yang sudah dibuat${NC}"
echo ""
read -p "$(echo -e "${YELLOW}Lanjutkan reinstall? [y/N] : ${NC}")" confirm

if [[ "$confirm" =~ ^[Yy]$ ]]; then
    clear
    banner
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${WHITE}      NISA VPN REINSTALL VPS${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${CYAN}Memulai reinstall ${WHITE}${OS_CMD}${CYAN}...${NC}"
    echo -e "${GREEN}Tunggu sekitar 5-15 menit setelah VPS reboot.${NC}"
    echo -e "${YELLOW}Developer : Hanief Autophile${NC}"
    echo -e "${YELLOW}Github    : https://github.com/haniefautophile-official${NC}"
    echo ""
    sleep 2
    bash reinstall.sh $OS_CMD --username root --password "$ROOT_PASS"
    reboot
    break
else
    echo ""
    echo -e "${YELLOW}Dibatalkan. Kembali ke menu...${NC}"
    sleep 2
fi

done
