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

bash /data/data/com.termux/files/home/termux-ubuntu/banner
package() {

    echo -e "${R} [${W}-${R}]${C} Purging packages..."${W}
    proot-distro remove ubuntu
    rm -rf $PREFIX/bin/ubuntu
    sed -i 's/pulseaudio/#pulseaudio/g' ~/.bashrc
    sed -i 's/pacmd/#pacmd/g' ~/.bashrc
    echo -e "${R} [${W}-${R}]${C} Purging Completed !"${W}

}

package

