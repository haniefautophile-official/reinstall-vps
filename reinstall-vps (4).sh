#!/bin/bash
# ============================================================
#   VPS REINSTALL SCRIPT - Multi OS Support
#   Supported: Ubuntu, Debian, CentOS, AlmaLinux, Rocky,
#              Fedora, openSUSE, Alpine, Kali Linux
#   Author   : Hanief Autophile
#   Usage    : bash reinstall-vps.sh
# ============================================================

# ── Warna Terminal ───────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# ── Lebar Box ────────────────────────────────────────────────
W=58

# ── Helper Box ───────────────────────────────────────────────
box_top()    { echo -e "${CYAN}${BOLD}╔$(printf '═%.0s' $(seq 1 $W))╗${NC}"; }
box_mid()    { echo -e "${CYAN}${BOLD}╠$(printf '═%.0s' $(seq 1 $W))╣${NC}"; }
box_bottom() { echo -e "${CYAN}${BOLD}╚$(printf '═%.0s' $(seq 1 $W))╝${NC}"; }
sep_line()   { echo -e "${DIM}$(printf '─%.0s' $(seq 1 $((W+2))))${NC}"; }

box_line() {
    local text="$1"
    local color="${2:-${CYAN}${BOLD}}"
    local len=${#text}
    local pad=$(( (W - len) / 2 ))
    local rpad=$(( W - len - pad ))
    printf "${color}║%${pad}s%s%${rpad}s║${NC}\n" "" "$text" ""
}

red_top()    { echo -e "${RED}${BOLD}╔$(printf '═%.0s' $(seq 1 $W))╗${NC}"; }
red_bottom() { echo -e "${RED}${BOLD}╚$(printf '═%.0s' $(seq 1 $W))╝${NC}"; }
red_line() {
    local text="$1"
    local len=${#text}
    local pad=$(( (W - len) / 2 ))
    local rpad=$(( W - len - pad ))
    printf "${RED}${BOLD}║%${pad}s%s%${rpad}s║${NC}\n" "" "$text" ""
}

grn_top()    { echo -e "${GREEN}${BOLD}╔$(printf '═%.0s' $(seq 1 $W))╗${NC}"; }
grn_bottom() { echo -e "${GREEN}${BOLD}╚$(printf '═%.0s' $(seq 1 $W))╝${NC}"; }
grn_line() {
    local text="$1"
    local len=${#text}
    local pad=$(( (W - len) / 2 ))
    local rpad=$(( W - len - pad ))
    printf "${GREEN}${BOLD}║%${pad}s%s%${rpad}s║${NC}\n" "" "$text" ""
}

# ── Banner Utama ─────────────────────────────────────────────
show_banner() {
    clear
    echo ""
    box_top
    box_line "  VPS REINSTALL SCRIPT  "
    box_line "  by Hanief Autophile   "
    box_mid
    box_line "Ubuntu | Debian | CentOS | Rocky | AlmaLinux"
    box_line "  Fedora | openSUSE | Alpine | Kali Linux  "
    box_bottom
    echo ""
}

# ── Cek Root ─────────────────────────────────────────────────
check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo -e " ${RED}[✗] Script harus dijalankan sebagai root!${NC}"
        echo -e "     ${DIM}Gunakan: sudo bash reinstall-vps.sh${NC}"
        echo ""
        exit 1
    fi
}

# ── Cek Dependensi ───────────────────────────────────────────
check_dependencies() {
    for dep in wget curl; do
        if ! command -v "$dep" &>/dev/null; then
            echo -e " ${YELLOW}[~] Menginstall $dep...${NC}"
            command -v apt-get &>/dev/null && apt-get install -y "$dep" &>/dev/null
            command -v yum     &>/dev/null && yum     install -y "$dep" &>/dev/null
        fi
    done
}

# ── Deteksi OS Saat Ini ──────────────────────────────────────
detect_current_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        CURRENT_OS="$NAME"
        CURRENT_VERSION="$VERSION_ID"
    else
        CURRENT_OS="Unknown"; CURRENT_VERSION="Unknown"
    fi
    printf " ${BLUE}[i]${NC} OS Saat Ini  : ${BOLD}%s %s${NC}\n" "$CURRENT_OS" "$CURRENT_VERSION"
    printf " ${BLUE}[i]${NC} Hostname     : ${BOLD}%s${NC}\n" "$(hostname)"
    echo ""
}

# ── Menu OS ──────────────────────────────────────────────────
show_os_menu() {
    sep_line
    printf "     ${BOLD}%-4s %-22s %-4s %-22s${NC}\n" "No." "OS" "No." "OS"
    sep_line
    printf "     ${GREEN}[1]${NC} %-22s ${GREEN}[6]${NC} %-22s\n" "Ubuntu"      "Fedora"
    printf "     ${GREEN}[2]${NC} %-22s ${GREEN}[7]${NC} %-22s\n" "Debian"      "openSUSE"
    printf "     ${GREEN}[3]${NC} %-22s ${GREEN}[8]${NC} %-22s\n" "CentOS"      "Alpine Linux"
    printf "     ${GREEN}[4]${NC} %-22s ${GREEN}[9]${NC} %-22s\n" "AlmaLinux"   "Kali Linux"
    printf "     ${GREEN}[5]${NC} %-22s ${RED}[0]${NC} %-22s\n"   "Rocky Linux" "Keluar"
    sep_line
    echo ""
    read -rp "$(printf " ${YELLOW}Pilih OS [0-9] : ${NC}")" OS_CHOICE
    echo ""
}

# ── Template Sub-menu Versi ───────────────────────────────────
pick_version() {
    local title="$1"; shift
    local opts=("$@")
    sep_line
    printf "     ${BOLD}%s — Pilih Versi${NC}\n" "$title"
    sep_line
    local i=1
    for opt in "${opts[@]}"; do
        printf "     ${GREEN}[%d]${NC}  %s\n" "$i" "$opt"
        (( i++ ))
    done
    sep_line
    echo ""
    read -rp "$(printf " ${YELLOW}Pilih versi [1-$((i-1))] : ${NC}")" VER_CHOICE
    echo ""
}

# ── Versi Per OS ─────────────────────────────────────────────
choose_ubuntu_version() {
    pick_version "UBUNTU" \
        "Ubuntu 20.04 LTS  (Focal Fossa)     - Stabil & populer" \
        "Ubuntu 22.04 LTS  (Jammy Jellyfish)  - LTS terbaru" \
        "Ubuntu 24.04 LTS  (Noble Numbat)     - Paling baru" \
        "Ubuntu 18.04 LTS  (Bionic Beaver)    - Legacy"
    case $VER_CHOICE in
        1) OS_NAME="ubuntu"; OS_VERSION="20.04"; OS_CODENAME="focal" ;;
        2) OS_NAME="ubuntu"; OS_VERSION="22.04"; OS_CODENAME="jammy" ;;
        3) OS_NAME="ubuntu"; OS_VERSION="24.04"; OS_CODENAME="noble" ;;
        4) OS_NAME="ubuntu"; OS_VERSION="18.04"; OS_CODENAME="bionic" ;;
        *) echo -e " ${RED}[✗] Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

choose_debian_version() {
    pick_version "DEBIAN" \
        "Debian 12  (Bookworm) - Terbaru & stabil" \
        "Debian 11  (Bullseye) - LTS populer" \
        "Debian 10  (Buster)   - Legacy" \
        "Debian  9  (Stretch)  - Very old"
    case $VER_CHOICE in
        1) OS_NAME="debian"; OS_VERSION="12"; OS_CODENAME="bookworm" ;;
        2) OS_NAME="debian"; OS_VERSION="11"; OS_CODENAME="bullseye" ;;
        3) OS_NAME="debian"; OS_VERSION="10"; OS_CODENAME="buster" ;;
        4) OS_NAME="debian"; OS_VERSION="9";  OS_CODENAME="stretch" ;;
        *) echo -e " ${RED}[✗] Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

choose_centos_version() {
    pick_version "CENTOS" \
        "CentOS Stream 9 - Terkini" \
        "CentOS Stream 8 - Populer" \
        "CentOS 7        - Legacy (EOL 2024)"
    case $VER_CHOICE in
        1) OS_NAME="centos"; OS_VERSION="stream9" ;;
        2) OS_NAME="centos"; OS_VERSION="stream8" ;;
        3) OS_NAME="centos"; OS_VERSION="7" ;;
        *) echo -e " ${RED}[✗] Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

choose_almalinux_version() {
    pick_version "ALMALINUX" \
        "AlmaLinux 9.x - Terbaru" \
        "AlmaLinux 8.x - Stabil"
    case $VER_CHOICE in
        1) OS_NAME="almalinux"; OS_VERSION="9" ;;
        2) OS_NAME="almalinux"; OS_VERSION="8" ;;
        *) echo -e " ${RED}[✗] Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

choose_rocky_version() {
    pick_version "ROCKY LINUX" \
        "Rocky Linux 9.x - Terbaru" \
        "Rocky Linux 8.x - Stabil"
    case $VER_CHOICE in
        1) OS_NAME="rocky"; OS_VERSION="9" ;;
        2) OS_NAME="rocky"; OS_VERSION="8" ;;
        *) echo -e " ${RED}[✗] Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

choose_fedora_version() {
    pick_version "FEDORA" \
        "Fedora 40 - Terbaru" \
        "Fedora 39 - Stabil" \
        "Fedora 38 - Lama"
    case $VER_CHOICE in
        1) OS_NAME="fedora"; OS_VERSION="40" ;;
        2) OS_NAME="fedora"; OS_VERSION="39" ;;
        3) OS_NAME="fedora"; OS_VERSION="38" ;;
        *) echo -e " ${RED}[✗] Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

choose_opensuse_version() {
    pick_version "OPENSUSE" \
        "openSUSE Tumbleweed  - Rolling release" \
        "openSUSE Leap 15.5   - Stabil" \
        "openSUSE Leap 15.4   - Lama"
    case $VER_CHOICE in
        1) OS_NAME="opensuse"; OS_VERSION="tumbleweed" ;;
        2) OS_NAME="opensuse"; OS_VERSION="leap-15.5" ;;
        3) OS_NAME="opensuse"; OS_VERSION="leap-15.4" ;;
        *) echo -e " ${RED}[✗] Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

choose_alpine_version() {
    pick_version "ALPINE LINUX" \
        "Alpine 3.19 - Terbaru" \
        "Alpine 3.18 - Stabil" \
        "Alpine 3.17 - Lama"
    case $VER_CHOICE in
        1) OS_NAME="alpine"; OS_VERSION="3.19" ;;
        2) OS_NAME="alpine"; OS_VERSION="3.18" ;;
        3) OS_NAME="alpine"; OS_VERSION="3.17" ;;
        *) echo -e " ${RED}[✗] Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

choose_kali_version() {
    OS_NAME="kali"; OS_VERSION="latest"
    echo -e " ${YELLOW}[~] Kali Linux - menggunakan versi rolling terbaru.${NC}"
    echo ""
}

# ── Pilih Metode ─────────────────────────────────────────────
choose_method() {
    sep_line
    printf "     ${BOLD}Pilih Metode Reinstall${NC}\n"
    sep_line
    printf "     ${GREEN}[1]${NC}  Otomatis via Script     ${DIM}(Rekomendasi)${NC}\n"
    printf "     ${GREEN}[2]${NC}  Manual via netboot.xyz  ${DIM}(Entry GRUB)${NC}\n"
    sep_line
    echo ""
    read -rp "$(printf " ${YELLOW}Pilih metode [1-2] : ${NC}")" METHOD_CHOICE
    echo ""
    case $METHOD_CHOICE in
        2) RUN_METHOD="netboot" ;;
        *) RUN_METHOD="auto" ;;
    esac
}

# ── Input Password ────────────────────────────────────────────
get_new_password() {
    sep_line
    printf "     ${BOLD}Konfigurasi Password Root${NC}\n"
    sep_line
    echo ""
    while true; do
        read -rp "$(printf " ${YELLOW}Password baru           : ${NC}")" NEW_PASSWORD
        read -rp "$(printf " ${YELLOW}Konfirmasi password     : ${NC}")" CONFIRM_PASSWORD
        echo ""
        if [ -z "$NEW_PASSWORD" ]; then
            echo -e " ${RED}[✗] Password tidak boleh kosong!${NC}"; echo ""
        elif [ "$NEW_PASSWORD" != "$CONFIRM_PASSWORD" ]; then
            echo -e " ${RED}[✗] Password tidak cocok, coba lagi!${NC}"; echo ""
        else
            echo -e " ${GREEN}[✓] Password valid.${NC}"; echo ""; break
        fi
    done
}

# ── Konfirmasi Akhir ──────────────────────────────────────────
confirm_reinstall() {
    local pub_ip
    pub_ip=$(curl -s --max-time 5 ifconfig.me 2>/dev/null || echo "Tidak terdeteksi")
    echo ""
    red_top
    red_line "  ⚠   PERINGATAN — KONFIRMASI AKHIR   ⚠  "
    red_bottom
    echo ""
    printf "  ${YELLOW}  %-14s :${NC} ${BOLD}%s %s${NC}\n"  "OS Target"  "$OS_NAME" "$OS_VERSION"
    printf "  ${YELLOW}  %-14s :${NC} ${BOLD}%s${NC}\n"    "Hostname"   "$(hostname)"
    printf "  ${YELLOW}  %-14s :${NC} ${BOLD}%s${NC}\n"    "IP Publik"  "$pub_ip"
    echo ""
    echo -e "  ${RED}  !! SEMUA DATA AKAN TERHAPUS PERMANEN !!${NC}"
    echo -e "  ${RED}  Server akan di-reinstall dari awal.${NC}"
    echo ""
    read -rp "$(printf "  ${RED}${BOLD}Ketik YES untuk melanjutkan : ${NC}")" CONFIRM
    echo ""
    if [ "$CONFIRM" != "YES" ]; then
        echo -e " ${YELLOW}[~] Reinstall dibatalkan.${NC}"; echo ""; exit 0
    fi
}

# ── Jalankan Reinstall (auto) ─────────────────────────────────
run_reinstall_via_dd() {
    echo -e " ${CYAN}[~] Mengunduh reinstall engine...${NC}"
    if command -v wget &>/dev/null; then
        wget -qO reinstall.sh \
            https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh
    else
        curl -fsSL -o reinstall.sh \
            https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh
    fi
    chmod +x reinstall.sh
    echo -e " ${GREEN}[✓] Menjalankan : ${BOLD}${OS_NAME} ${OS_VERSION}${NC}"
    echo ""
    case $OS_NAME in
        ubuntu|debian|centos|almalinux|rocky|fedora|opensuse|alpine)
            bash reinstall.sh "$OS_NAME" "$OS_VERSION" --password "$NEW_PASSWORD" ;;
        kali)
            bash reinstall.sh kali --password "$NEW_PASSWORD" ;;
        *)
            echo -e " ${RED}[✗] OS tidak dikenali: $OS_NAME${NC}"; exit 1 ;;
    esac
}

# ── Jalankan Reinstall (netboot) ──────────────────────────────
run_reinstall_via_netboot() {
    echo -e " ${CYAN}[~] Menyiapkan netboot.xyz via GRUB...${NC}"
    command -v apt-get &>/dev/null && apt-get install -y wget grub-common  &>/dev/null
    command -v yum     &>/dev/null && yum     install -y wget grub2-tools  &>/dev/null
    wget -qO /boot/netboot.xyz.lkrn https://boot.netboot.xyz/ipxe/netboot.xyz.lkrn
    if [ -f /etc/grub.d/40_custom ]; then
        cat >> /etc/grub.d/40_custom <<'EOF'

menuentry "Netboot.xyz" {
    linux16 /boot/netboot.xyz.lkrn
}
EOF
        update-grub 2>/dev/null || grub2-mkconfig -o /boot/grub2/grub.cfg 2>/dev/null
        echo -e " ${GREEN}[✓] Netboot.xyz ditambahkan ke GRUB.${NC}"
        echo -e " ${YELLOW}[!] Reboot, lalu pilih 'Netboot.xyz' di menu GRUB.${NC}"
    else
        echo -e " ${RED}[✗] GRUB custom file tidak ditemukan.${NC}"
    fi
}

# ── Info Selesai + Prompt Reboot ─────────────────────────────
show_post_info() {
    local pub_ip
    pub_ip=$(curl -s --max-time 5 ifconfig.me 2>/dev/null || echo "?")

    echo ""
    grn_top
    grn_line "  ✓  REINSTALL SIAP — RINGKASAN  "
    grn_bottom
    echo ""
    printf "  ${CYAN}  %-14s :${NC} ${BOLD}%s %s${NC}\n"  "OS Target"  "$OS_NAME" "$OS_VERSION"
    printf "  ${CYAN}  %-14s :${NC} ${BOLD}%s${NC}\n"     "IP Server"  "$pub_ip"
    printf "  ${CYAN}  %-14s :${NC} ${BOLD}root${NC}\n"   "Username"
    printf "  ${CYAN}  %-14s :${NC} ${BOLD}%s${NC}\n"     "Password"   "$NEW_PASSWORD"
    echo ""
    sep_line
    echo -e "  ${YELLOW}[!] Instalasi OS dimulai SETELAH server reboot.${NC}"
    echo -e "  ${YELLOW}[!] Tunggu 5-15 menit, lalu SSH kembali ke server.${NC}"
    echo -e "  ${YELLOW}[!] Jika gagal SSH, instalasi masih berlangsung.${NC}"
    sep_line
    echo ""
    echo -e "  ${BLUE}Perintah SSH setelah selesai :${NC}"
    echo -e "    ${BOLD}ssh root@${pub_ip}${NC}"
    echo ""

    # ── Prompt Reboot ──
    sep_line
    while true; do
        read -rp "$(printf "  ${GREEN}${BOLD}Reboot sekarang untuk mulai instalasi? [y/n] : ${NC}")" REBOOT_CONFIRM
        case "$REBOOT_CONFIRM" in
            y|Y)
                echo ""
                echo -e "  ${GREEN}[✓] Rebooting...${NC}"
                echo ""
                sleep 2
                reboot
                break
                ;;
            n|N)
                echo ""
                echo -e "  ${YELLOW}[~] Reboot dibatalkan.${NC}"
                echo -e "  ${DIM}      Jalankan 'reboot' secara manual jika sudah siap.${NC}"
                echo ""
                break
                ;;
            *)
                echo -e "  ${RED}[✗] Masukkan y atau n${NC}"
                ;;
        esac
    done
}

# ══════════════════════════════════════════════════════════════
#   MAIN
# ══════════════════════════════════════════════════════════════
main() {
    show_banner
    check_root
    check_dependencies
    detect_current_os
    show_os_menu

    case $OS_CHOICE in
        1) choose_ubuntu_version ;;
        2) choose_debian_version ;;
        3) choose_centos_version ;;
        4) choose_almalinux_version ;;
        5) choose_rocky_version ;;
        6) choose_fedora_version ;;
        7) choose_opensuse_version ;;
        8) choose_alpine_version ;;
        9) choose_kali_version ;;
        0) echo -e " ${YELLOW}Keluar.${NC}"; echo ""; exit 0 ;;
        *) echo -e " ${RED}[✗] Pilihan tidak valid!${NC}"; exit 1 ;;
    esac

    choose_method
    get_new_password
    confirm_reinstall

    [ "$RUN_METHOD" = "auto" ] && run_reinstall_via_dd || run_reinstall_via_netboot

    show_post_info
}

main "$@"
