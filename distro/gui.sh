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

package() {
    bash /data/data/com.termux/files/home/termux-ubuntu/banner
    echo -e "${R} [${W}-${R}]${C} Checking required packages..."${W}
    sudo apt-get update -y
    sudo apt install udisks2 -y
    sudo rm /var/lib/dpkg/info/udisks2.postinst
    echo "" > /var/lib/dpkg/info/udisks2.postinst
    sudo dpkg --configure -a
    sudo apt-mark hold udisks2
    packs=(sudo wget curl nano git xfce4 xfce4-terminal firefox tigervnc-standalone-server tigervnc-common fonts-indic fonts-emojione openjdk-8-jdk )
    for pack in "${packs[@]}"; do
        type -p "$pack" &>/dev/null || {
            echo -e "\n${R} [${W}-${R}]${G} Installing package : ${Y}$pack${C}"${W}
            sudo apt install "$pack" -y --no-install-recommends
        }
    done
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt clean
}

u-chromium() {
    bash /data/data/com.termux/files/home/termux-ubuntu/banner
    echo -e "${R} [${W}-${R}]${C} Uninstalling OLD chromium..."${W}
    chrome=(chromium* chromium-browser* snapd)
    for pack in "${chrome[@]}"; do
        type -p "$pack" &>/dev/null || {
            echo -e "\n${R} [${W}-${R}]${G} Purging package : ${Y}$pack${C}"${W}
            apt purge "$pack" -y && apt autoremove -y
            sudo apt purge "$pack" -y && sudo apt autoremove -y
        }
    done
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install software-properties-common gnupg --no-install-recommends -y
}
i-chromium() {
    bash /data/data/com.termux/files/home/termux-ubuntu/banner
    echo -e "${R} [${W}-${R}]${C} Installing Chromium..."${W}
    sudo echo "deb http://ftp.debian.org/debian buster main
deb http://ftp.debian.org/debian buster-updates main" >> /etc/apt/sources.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DCC9EFBF77E11517
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AA8E81B4331F7F50
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 112695A0E562B32A
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
    sudo apt update -y
    sudo apt install chromium -y
    sudo sed -i 's/chromium %U/chromium --no-sandbox %U/g' /usr/share/applications/chromium.desktop
    sudo apt upgrade -y
}

refs() {
    bash /data/data/com.termux/files/home/termux-ubuntu/banner
    sudo apt update -y
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
    sudo apt upgrade -y
    sudo apt autoremove -y
}

vscode() {
    bash /data/data/com.termux/files/home/termux-ubuntu/banner
    echo -e "${R} [${W}-${R}]${C} Installing Visual Studio..."${W}

    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt install apt-transport-https -y
    sudo apt update -y
    sudo apt install code -y
}

theme(){
    bash /data/data/com.termux/files/home/termux-ubuntu/banner

    sudo rm -rf /usr/share/themes/*
    sudo rm -rf /usr/share/icons/*

    git clone --depth=1 https://github.com/vinceliuice/WhiteSur-gtk-theme.git $HOME/WhiteSur-gtk-theme
    sudo chmod +x $HOME/WhiteSur-gtk-theme/install.sh
    sudo bash $HOME/WhiteSur-gtk-theme/install.sh -c dark -a all -t orange -s 180 -HD --round --dialog

    git clone --depth=1 https://github.com/vinceliuice/WhiteSur-icon-theme.git $HOME/WhiteSur-icon-theme
    sudo chmod +x $HOME/WhiteSur-icon-theme/install.sh
    sudo bash $HOME/WhiteSur-icon-theme/install.sh -t orange -b --black

    git clone --depth=1 https://github.com/vinceliuice/WhiteSur-cursors.git $HOME/WhiteSur-cursors
    sudo chmod +x $HOME/WhiteSur-cursors/install.sh
    sudo bash $HOME/WhiteSur-cursors/install.sh

    git clone --depth=1 https://github.com/s-h-3-l-l/katoolin3.git $HOME/katoolin3
    sudo chmod +x $HOME/katoolin3/install.sh
    cd $HOME/katoolin3 && sudo bash install.sh

    sudo apt update -y
    sudo apt autoremove -y

}

vnc() {
    bash /data/data/com.termux/files/home/termux-ubuntu/banner
    echo -e "${R} [${W}-${R}]${C} Setting up VNC Server..."${W}

    if [[ ! -d "$HOME/.vnc" ]]; then
        mkdir -p "$HOME/.vnc"
    fi

    if [[ -e "$HOME/.vnc/xstartup" ]]; then
        rm -rf $HOME/.vnc/xstartup
    fi

    cp -f /data/data/com.termux/files/home/termux-ubuntu/distro/xstartup $HOME/.vnc/xstartup
    chmod +x $HOME/.vnc/xstartup

    if [[ -e "/usr/local/bin/vncstart" ]]; then
        rm -rf /usr/local/bin/vncstart
    fi

    cp -f /data/data/com.termux/files/home/termux-ubuntu/distro/vncstart /usr/local/bin/vncstart
    chmod +x /usr/local/bin/vncstart

    if [[ -e "/usr/local/bin/vncstop" ]]; then
        rm -rf /usr/local/bin/vncstop
    fi

    cp -f /data/data/com.termux/files/home/termux-ubuntu/distro/vncstop /usr/local/bin/vncstop
    chmod +x /usr/local/bin/vncstop

    echo "export DISPLAY=":1"" >> /etc/profile
    echo "export PULSE_SERVER=127.0.0.1" >> /etc/profile
    source /etc/profile

}

note() {
    bash /data/data/com.termux/files/home/termux-ubuntu/banner
    echo -e " ${G} Successfully Installed !"${W}
    sleep 1
    echo
    echo -e " ${G}Type ${C}vncstart${G} to start Vncserver."${W}
    echo -e " ${G}Type ${C}vncstop ${G} to stop  Vncserver."${W}
    echo
    echo -e " ${C}Install VNC VIEWER Apk on your Device."${W}
    echo
    echo -e " ${C}Open VNC VIEWER & Click on + Button."${W}
    echo
    echo -e " ${C}Enter the Address localhost:1 & Name anything you like."${W}
    echo
    echo -e " ${C}Set the Picture Quality to High for better Quality."${W}
    echo
    echo -e " ${C}Click on Connect & Input the Password."${W}
    echo
    echo -e " ${C}Enjoy :D"${W}
    echo
    echo
}

package
u-chromium
i-chromium
refs
vscode
theme
vnc
note
