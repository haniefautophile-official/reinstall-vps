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
1)
bash reinstall.sh debian 10
break
;;
2)
bash reinstall.sh debian 11
break
;;
3)
bash reinstall.sh debian 12
break
;;
4)
bash reinstall.sh ubuntu 20.04
break
;;
5)
bash reinstall.sh ubuntu 22.04
break
;;
6)
bash reinstall.sh ubuntu 24.04
break
;;
x)
exit
;;
*)
echo "Pilihan tidak valid"
sleep 2
;;
esac
done

clear
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${WHITE}      NISA VPN REINSTALL VPS${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${CYAN}Proses reinstall telah dimulai${NC}"
echo -e "${YELLOW}Developer : Hanief Autophile${NC}"
echo -e "${YELLOW}Github    : https://github.com/haniefautophile-official${NC}"
echo ""
echo -e "${GREEN}Tunggu sekitar 5-15 menit hingga selesai${NC}"
echo ""
