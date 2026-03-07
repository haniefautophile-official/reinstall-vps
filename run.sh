#!/bin/bash
# ============================================================
#   VPS REINSTALL SCRIPT - Multi OS Support
#   Supported: Ubuntu, Debian, CentOS, AlmaLinux, Rocky,
#              Fedora, openSUSE, Alpine, Kali Linux
#   Author   : Hanief Autophile
#   Usage    : bash reinstall-vps.sh
# ============================================================

# ── Warna Terminal ──────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# ── Fungsi Banner ────────────────────────────────────────────
show_banner() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║          VPS REINSTALL SCRIPT BY HANIEF AUTOPHILE- Multi OS             ║"
    echo "║     Ubuntu | Debian | CentOS | Rocky | AlmaLinux     ║"
    echo "║        Fedora | openSUSE | Alpine | Kali Linux        ║"
    echo "╚══════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# ── Cek Root ─────────────────────────────────────────────────
check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo -e "${RED}[ERROR] Script ini harus dijalankan sebagai root!${NC}"
        echo -e "Gunakan: ${YELLOW}sudo bash reinstall-vps.sh${NC}"
        exit 1
    fi
}

# ── Cek Tool yang Dibutuhkan ──────────────────────────────────
check_dependencies() {
    local deps=("wget" "curl")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &>/dev/null; then
            echo -e "${YELLOW}[INFO] Menginstall $dep...${NC}"
            if command -v apt-get &>/dev/null; then
                apt-get install -y "$dep" &>/dev/null
            elif command -v yum &>/dev/null; then
                yum install -y "$dep" &>/dev/null
            fi
        fi
    done
}

# ── Deteksi OS Saat Ini ───────────────────────────────────────
detect_current_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        CURRENT_OS="$NAME"
        CURRENT_VERSION="$VERSION_ID"
    else
        CURRENT_OS="Unknown"
        CURRENT_VERSION="Unknown"
    fi
    echo -e "${BLUE}[INFO] OS Saat Ini: ${BOLD}$CURRENT_OS $CURRENT_VERSION${NC}"
}

# ── Menu Pilihan OS ───────────────────────────────────────────
show_os_menu() {
    echo ""
    echo -e "${BOLD}╔══════════════════════════════════╗${NC}"
    echo -e "${BOLD}║         PILIH OS TARGET          ║${NC}"
    echo -e "${BOLD}╚══════════════════════════════════╝${NC}"
    echo ""
    echo -e " ${GREEN}[1]${NC}  Ubuntu"
    echo -e " ${GREEN}[2]${NC}  Debian"
    echo -e " ${GREEN}[3]${NC}  CentOS"
    echo -e " ${GREEN}[4]${NC}  AlmaLinux"
    echo -e " ${GREEN}[5]${NC}  Rocky Linux"
    echo -e " ${GREEN}[6]${NC}  Fedora"
    echo -e " ${GREEN}[7]${NC}  openSUSE"
    echo -e " ${GREEN}[8]${NC}  Alpine Linux"
    echo -e " ${GREEN}[9]${NC}  Kali Linux"
    echo -e " ${RED}[0]${NC}  Keluar"
    echo ""
    read -rp "$(echo -e ${YELLOW}"Pilih OS [0-9]: "${NC})" OS_CHOICE
}

# ── Menu Versi Ubuntu ─────────────────────────────────────────
choose_ubuntu_version() {
    echo ""
    echo -e "${BOLD}=== UBUNTU - Pilih Versi ===${NC}"
    echo " [1] Ubuntu 20.04 LTS (Focal Fossa)    - Stabil, populer"
    echo " [2] Ubuntu 22.04 LTS (Jammy Jellyfish) - LTS terbaru"
    echo " [3] Ubuntu 24.04 LTS (Noble Numbat)   - Terbaru"
    echo " [4] Ubuntu 18.04 LTS (Bionic Beaver)  - Legacy"
    echo ""
    read -rp "$(echo -e ${YELLOW}"Pilih versi [1-4]: "${NC})" VER_CHOICE

    case $VER_CHOICE in
        1) OS_NAME="ubuntu"; OS_VERSION="20.04"; OS_CODENAME="focal" ;;
        2) OS_NAME="ubuntu"; OS_VERSION="22.04"; OS_CODENAME="jammy" ;;
        3) OS_NAME="ubuntu"; OS_VERSION="24.04"; OS_CODENAME="noble" ;;
        4) OS_NAME="ubuntu"; OS_VERSION="18.04"; OS_CODENAME="bionic" ;;
        *) echo -e "${RED}Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

# ── Menu Versi Debian ─────────────────────────────────────────
choose_debian_version() {
    echo ""
    echo -e "${BOLD}=== DEBIAN - Pilih Versi ===${NC}"
    echo " [1] Debian 12 (Bookworm) - Terbaru & stabil"
    echo " [2] Debian 11 (Bullseye) - LTS populer"
    echo " [3] Debian 10 (Buster)   - Legacy"
    echo " [4] Debian 9  (Stretch)  - Sangat lama"
    echo ""
    read -rp "$(echo -e ${YELLOW}"Pilih versi [1-4]: "${NC})" VER_CHOICE

    case $VER_CHOICE in
        1) OS_NAME="debian"; OS_VERSION="12"; OS_CODENAME="bookworm" ;;
        2) OS_NAME="debian"; OS_VERSION="11"; OS_CODENAME="bullseye" ;;
        3) OS_NAME="debian"; OS_VERSION="10"; OS_CODENAME="buster" ;;
        4) OS_NAME="debian"; OS_VERSION="9";  OS_CODENAME="stretch" ;;
        *) echo -e "${RED}Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

# ── Menu Versi CentOS ─────────────────────────────────────────
choose_centos_version() {
    echo ""
    echo -e "${BOLD}=== CentOS - Pilih Versi ===${NC}"
    echo " [1] CentOS Stream 9 - Terkini"
    echo " [2] CentOS Stream 8 - Populer"
    echo " [3] CentOS 7        - Legacy (EOL 2024)"
    echo ""
    read -rp "$(echo -e ${YELLOW}"Pilih versi [1-3]: "${NC})" VER_CHOICE

    case $VER_CHOICE in
        1) OS_NAME="centos"; OS_VERSION="stream9" ;;
        2) OS_NAME="centos"; OS_VERSION="stream8" ;;
        3) OS_NAME="centos"; OS_VERSION="7" ;;
        *) echo -e "${RED}Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

# ── Menu Versi AlmaLinux ──────────────────────────────────────
choose_almalinux_version() {
    echo ""
    echo -e "${BOLD}=== AlmaLinux - Pilih Versi ===${NC}"
    echo " [1] AlmaLinux 9.x - Terbaru"
    echo " [2] AlmaLinux 8.x - Stabil"
    echo ""
    read -rp "$(echo -e ${YELLOW}"Pilih versi [1-2]: "${NC})" VER_CHOICE

    case $VER_CHOICE in
        1) OS_NAME="almalinux"; OS_VERSION="9" ;;
        2) OS_NAME="almalinux"; OS_VERSION="8" ;;
        *) echo -e "${RED}Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

# ── Menu Versi Rocky Linux ────────────────────────────────────
choose_rocky_version() {
    echo ""
    echo -e "${BOLD}=== Rocky Linux - Pilih Versi ===${NC}"
    echo " [1] Rocky Linux 9.x - Terbaru"
    echo " [2] Rocky Linux 8.x - Stabil"
    echo ""
    read -rp "$(echo -e ${YELLOW}"Pilih versi [1-2]: "${NC})" VER_CHOICE

    case $VER_CHOICE in
        1) OS_NAME="rocky"; OS_VERSION="9" ;;
        2) OS_NAME="rocky"; OS_VERSION="8" ;;
        *) echo -e "${RED}Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

# ── Menu Versi Fedora ─────────────────────────────────────────
choose_fedora_version() {
    echo ""
    echo -e "${BOLD}=== Fedora - Pilih Versi ===${NC}"
    echo " [1] Fedora 40 - Terbaru"
    echo " [2] Fedora 39 - Stabil"
    echo " [3] Fedora 38 - Lama"
    echo ""
    read -rp "$(echo -e ${YELLOW}"Pilih versi [1-3]: "${NC})" VER_CHOICE

    case $VER_CHOICE in
        1) OS_NAME="fedora"; OS_VERSION="40" ;;
        2) OS_NAME="fedora"; OS_VERSION="39" ;;
        3) OS_NAME="fedora"; OS_VERSION="38" ;;
        *) echo -e "${RED}Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

# ── Menu Versi openSUSE ───────────────────────────────────────
choose_opensuse_version() {
    echo ""
    echo -e "${BOLD}=== openSUSE - Pilih Versi ===${NC}"
    echo " [1] openSUSE Tumbleweed - Rolling release"
    echo " [2] openSUSE Leap 15.5  - Stabil"
    echo " [3] openSUSE Leap 15.4  - Lama"
    echo ""
    read -rp "$(echo -e ${YELLOW}"Pilih versi [1-3]: "${NC})" VER_CHOICE

    case $VER_CHOICE in
        1) OS_NAME="opensuse"; OS_VERSION="tumbleweed" ;;
        2) OS_NAME="opensuse"; OS_VERSION="leap-15.5" ;;
        3) OS_NAME="opensuse"; OS_VERSION="leap-15.4" ;;
        *) echo -e "${RED}Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

# ── Menu Versi Alpine ─────────────────────────────────────────
choose_alpine_version() {
    echo ""
    echo -e "${BOLD}=== Alpine Linux - Pilih Versi ===${NC}"
    echo " [1] Alpine 3.19 - Terbaru"
    echo " [2] Alpine 3.18 - Stabil"
    echo " [3] Alpine 3.17 - Lama"
    echo ""
    read -rp "$(echo -e ${YELLOW}"Pilih versi [1-3]: "${NC})" VER_CHOICE

    case $VER_CHOICE in
        1) OS_NAME="alpine"; OS_VERSION="3.19" ;;
        2) OS_NAME="alpine"; OS_VERSION="3.18" ;;
        3) OS_NAME="alpine"; OS_VERSION="3.17" ;;
        *) echo -e "${RED}Pilihan tidak valid!${NC}"; exit 1 ;;
    esac
}

# ── Konfirmasi Sebelum Reinstall ──────────────────────────────
confirm_reinstall() {
    echo ""
    echo -e "${RED}${BOLD}╔══════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}${BOLD}║              ⚠  PERINGATAN KERAS  ⚠                 ║${NC}"
    echo -e "${RED}${BOLD}╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW} OS Target   : ${BOLD}${OS_NAME} ${OS_VERSION}${NC}"
    echo -e "${YELLOW} Hostname    : ${BOLD}$(hostname)${NC}"
    echo -e "${YELLOW} IP Publik   : ${BOLD}$(curl -s ifconfig.me 2>/dev/null || echo 'Tidak terdeteksi')${NC}"
    echo ""
    echo -e "${RED} SEMUA DATA AKAN TERHAPUS PERMANEN!${NC}"
    echo -e "${RED} Server akan di-reinstall dari awal.${NC}"
    echo ""
    read -rp "$(echo -e ${RED}"Ketik 'YES' untuk melanjutkan: "${NC})" CONFIRM

    if [ "$CONFIRM" != "YES" ]; then
        echo -e "${YELLOW}[INFO] Reinstall dibatalkan.${NC}"
        exit 0
    fi
}

# ── Input Password Root Baru ──────────────────────────────────
get_new_password() {
    echo ""
    echo -e "${CYAN}=== Konfigurasi Password ===${NC}"
    while true; do
        read -rsp "$(echo -e ${YELLOW}"Masukkan password root baru: "${NC})" NEW_PASSWORD
        echo ""
        read -rsp "$(echo -e ${YELLOW}"Konfirmasi password: "${NC})" CONFIRM_PASSWORD
        echo ""
        if [ "$NEW_PASSWORD" = "$CONFIRM_PASSWORD" ]; then
            if [ ${#NEW_PASSWORD} -lt 8 ]; then
                echo -e "${RED}Password minimal 8 karakter!${NC}"
            else
                echo -e "${GREEN}Password valid.${NC}"
                break
            fi
        else
            echo -e "${RED}Password tidak cocok, coba lagi!${NC}"
        fi
    done
}

# ── Cek & Install dd-bootstrap / reinstall.sh ─────────────────
run_reinstall_via_dd() {
    echo ""
    echo -e "${CYAN}[INFO] Memulai proses reinstall menggunakan metode dd/bootstrap...${NC}"

    # Metode 1: Menggunakan script populer reinstall.sh (all-in-one)
    if command -v wget &>/dev/null; then
        echo -e "${YELLOW}[INFO] Mengunduh reinstall script (GitHub: bin456789/reinstall)...${NC}"
        wget -qO reinstall.sh https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh
    elif command -v curl &>/dev/null; then
        curl -fsSL -o reinstall.sh https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh
    else
        echo -e "${RED}[ERROR] wget atau curl tidak ditemukan!${NC}"
        exit 1
    fi

    chmod +x reinstall.sh

    echo -e "${GREEN}[INFO] Menjalankan reinstall untuk: ${BOLD}${OS_NAME} ${OS_VERSION}${NC}"
    echo ""

    # ── Jalankan berdasarkan OS yang dipilih ──
    case $OS_NAME in
        ubuntu)
            bash reinstall.sh ubuntu "$OS_VERSION" --password "$NEW_PASSWORD"
            ;;
        debian)
            bash reinstall.sh debian "$OS_VERSION" --password "$NEW_PASSWORD"
            ;;
        centos)
            bash reinstall.sh centos "$OS_VERSION" --password "$NEW_PASSWORD"
            ;;
        almalinux)
            bash reinstall.sh almalinux "$OS_VERSION" --password "$NEW_PASSWORD"
            ;;
        rocky)
            bash reinstall.sh rocky "$OS_VERSION" --password "$NEW_PASSWORD"
            ;;
        fedora)
            bash reinstall.sh fedora "$OS_VERSION" --password "$NEW_PASSWORD"
            ;;
        opensuse)
            bash reinstall.sh opensuse "$OS_VERSION" --password "$NEW_PASSWORD"
            ;;
        alpine)
            bash reinstall.sh alpine "$OS_VERSION" --password "$NEW_PASSWORD"
            ;;
        kali)
            bash reinstall.sh kali --password "$NEW_PASSWORD"
            ;;
        *)
            echo -e "${RED}[ERROR] OS tidak dikenali: $OS_NAME${NC}"
            exit 1
            ;;
    esac
}

# ── Metode Alternatif: netboot.xyz ────────────────────────────
run_reinstall_via_netboot() {
    echo ""
    echo -e "${CYAN}[INFO] Metode alternatif: netboot.xyz (via GRUB)...${NC}"

    if command -v apt-get &>/dev/null; then
        apt-get install -y wget grub-common &>/dev/null
    elif command -v yum &>/dev/null; then
        yum install -y wget grub2-tools &>/dev/null
    fi

    wget -qO /boot/netboot.xyz.lkrn https://boot.netboot.xyz/ipxe/netboot.xyz.lkrn

    if [ -f /etc/grub.d/40_custom ]; then
        cat >> /etc/grub.d/40_custom <<EOF

menuentry "Netboot.xyz" {
    linux16 /boot/netboot.xyz.lkrn
}
EOF
        update-grub 2>/dev/null || grub2-mkconfig -o /boot/grub2/grub.cfg 2>/dev/null
        echo -e "${GREEN}[INFO] Netboot.xyz ditambahkan ke GRUB. Reboot dan pilih 'Netboot.xyz'${NC}"
    fi
}

# ── Info Post Reinstall ───────────────────────────────────────
show_post_info() {
    echo ""
    echo -e "${GREEN}${BOLD}╔══════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}${BOLD}║           REINSTALL BERHASIL DIMULAI                 ║${NC}"
    echo -e "${GREEN}${BOLD}╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e " ${CYAN}OS Target    : ${BOLD}${OS_NAME} ${OS_VERSION}${NC}"
    echo -e " ${CYAN}IP Server    : ${BOLD}$(curl -s ifconfig.me 2>/dev/null)${NC}"
    echo -e " ${CYAN}Username     : ${BOLD}root${NC}"
    echo -e " ${CYAN}Password     : ${BOLD}[yang sudah Anda masukkan]${NC}"
    echo ""
    echo -e " ${YELLOW}[!] Server akan reboot otomatis dalam beberapa menit.${NC}"
    echo -e " ${YELLOW}[!] Tunggu 5-15 menit, lalu SSH kembali ke server Anda.${NC}"
    echo -e " ${YELLOW}[!] Jika tidak bisa SSH, tunggu lebih lama (instalasi OS berlangsung).${NC}"
    echo ""
    echo -e " ${BLUE}Cara SSH setelah reinstall selesai:${NC}"
    echo -e "   ${BOLD}ssh root@$(curl -s ifconfig.me 2>/dev/null)${NC}"
    echo ""
}

# ── Submenu Kali Linux ────────────────────────────────────────
choose_kali_version() {
    OS_NAME="kali"
    OS_VERSION="latest"
    echo -e "${YELLOW}[INFO] Kali Linux akan menggunakan versi rolling terbaru.${NC}"
}

# ── Metode Pemilihan ──────────────────────────────────────────
choose_method() {
    echo ""
    echo -e "${BOLD}=== PILIH METODE REINSTALL ===${NC}"
    echo " [1] Otomatis via Script (Rekomendasi - bin456789/reinstall)"
    echo " [2] Manual via netboot.xyz (Tambah entry GRUB)"
    echo ""
    read -rp "$(echo -e ${YELLOW}"Pilih metode [1-2]: "${NC})" METHOD_CHOICE

    case $METHOD_CHOICE in
        1) RUN_METHOD="auto" ;;
        2) RUN_METHOD="netboot" ;;
        *) RUN_METHOD="auto" ;;
    esac
}

# ══════════════════════════════════════════════════════════════
#   MAIN PROGRAM
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
        0) echo -e "${YELLOW}Keluar...${NC}"; exit 0 ;;
        *) echo -e "${RED}Pilihan tidak valid!${NC}"; exit 1 ;;
    esac

    choose_method
    get_new_password
    confirm_reinstall

    if [ "$RUN_METHOD" = "auto" ]; then
        run_reinstall_via_dd
    else
        run_reinstall_via_netboot
    fi

    show_post_info
}

main "$@"

