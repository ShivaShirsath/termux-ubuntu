#!/bin/bash

R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
W="$(printf '\033[1;37m')"
C="$(printf '\033[1;36m')"

sudo() {
    bash /data/data/com.termux/files/home/termux-ubuntu/banner
    echo -e "\n${R} [${W}-${R}]${C} Installing Sudo..."${W}
    apt update -y
    apt install sudo -y
    apt install wget -y
    echo -e "\n${R} [${W}-${R}]${G} Sudo Successfully Installed !"${W}
}

login() {
    bash /data/data/com.termux/files/home/termux-ubuntu/banner
    read -p $' \e[1;31m[\e[0m\e[1;77m~\e[0m\e[1;31m]\e[0m\e[1;92m Input Username [Lowercase] : \e[0m\e[1;96m\en' user
    echo -e "${W}"
    echo "$user ALL=(ALL:ALL) ALL" >> /etc/sudoers
    adduser $user
    echo "proot-distro login --user $user ubuntu-20.04" > $PREFIX/bin/ubuntu
    chmod +x $PREFIX/bin/ubuntu
    mv -vf /data/data/com.termux/files/home/termux-ubuntu/distro/gui.sh /home/$user/gui.sh
    chmod +x /home/$user/gui.sh
    clear
    echo
    echo -e "\n${R} [${W}-${R}]${G} Restart your Termux & Type ${C}ubuntu"${W}
    echo -e "\n${R} [${W}-${R}]${G} Then Type ${C}bash gui.sh "${W}
    echo

}

sudo
login
