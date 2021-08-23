#!/bin/bash

Z="$(printf '\033[0m\n')"
b="$(printf '\033[1;30m')"
R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
B="$(printf '\033[1;34m')"
P="$(printf '\033[1;35m')"
C="$(printf '\033[1;36m')"
W="$(printf '\033[1;37m')"

chmod +x /data/data/com.termux/files/home/termux-ubuntu/*
bash /data/data/com.termux/files/home/termux-ubuntu/banner

package() {
    echo -e "${R} [${W}-${R}]${C} Checking required packages..."${W}
    termux-setup-storage
    if [[ `command -v pulseaudio` && `command -v proot-distro` && `command -v wget` ]]; then
        echo -e "\n${R} [${W}-${R}]${G} Packages already installed."${W}
    else
        packs=(pulseaudio proot-distro wget)
        for pack in "${packs[@]}"; do
            type -p "$pack" &>/dev/null || {
                echo -e "\n${R} [${W}-${R}]${G} Installing package : ${Y}$pack${C}"${W}
                apt update -y
                apt upgrade -y
                apt install "$pack" -y
            }
        done
    fi
}

distro() {
    echo -e "\n${R} [${W}-${R}]${C} Checking for Distro..."${W}
    termux-reload-settings

    if [[ -d "$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu" ]]; then
        echo -e "\n${R} [${W}-${R}]${G} Distro already installed."${W}
        exit 0
    else
        proot-distro install ubuntu
        termux-reload-settings
    fi

    if [[ -d "$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu" ]]; then
        echo -e "\n${R} [${W}-${R}]${G} Installed Successfully !!"${W}
    else
        echo -e "\n${R} [${W}-${R}]${G} Error Installing Distro !\n"${W}
        exit 0
    fi
}

sound() {
    echo -e "\n${R} [${W}-${R}]${C} Fixing Sound Problem..."${W}
    if [[ ! -e "$HOME/.bashrc" ]]; then
        touch $HOME/.bashrc
    fi

    echo "pulseaudio --start --exit-idle-time=-1" >> $HOME/.bashrc
    echo "pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" >> $HOME/.bashrc
}

permission() {
    bash /data/data/com.termux/files/home/termux-ubuntu/banner
    echo -e "${R} [${W}-${R}]${C} Setting up Environment..."${W}

    if [[ -e "$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu/root/user.sh" ]]; then
        chmod +x $PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu/root/user.sh
    else
        cp -f /data/data/com.termux/files/home/termux-ubuntu/distro/user.sh $PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu/root/user.sh
        chmod +x $PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu/root/user.sh
    fi

    echo "proot-distro login ubuntu" > $PREFIX/bin/ubuntu

    if [[ -e "$PREFIX/bin/ubuntu" ]]; then
        chmod +x $PREFIX/bin/ubuntu
        termux-reload-settings
        bash /data/data/com.termux/files/home/termux-ubuntu/banner
        echo -e "\n${R} [${W}-${R}]${G} Ubuntu 20.04(CLI) is now Installed on your Termux"${W}
        echo -e "\n${R} [${W}-${R}]${G} Restart your Termux to Prevent Some Issues."${W}
        echo -e "\n${R} [${W}-${R}]${G} Type ${C}ubuntu${G} to run Ubuntu CLI."${W}
        echo -e "\n${R} [${W}-${R}]${G} If you Want to Use UBUNTU in GUI MODE then ,"${W}
        echo -e "\n${R} [${W}-${R}]${G} Run ${C}ubuntu${G} first & then type ${C}bash user.sh "${W}
        echo -e "\n"
        exit 0
    else
        echo -e "\n${R} [${W}-${R}]${G} Error Installing Distro !"${W}
        exit 0
    fi
}

#bash /data/data/com.termux/files/home/termux-ubuntu/banner
#package
#distro
#sound
#permission
