#!/data/data/com.termux/files/usr/bin/bash

termux-change-repo

pkg update > /dev/null 2>&1 || {
	echo "failed to update packges, change mirror"
	exit 1
}

pkg upgrade -y

pkg install -y x11-repo
pkg install -y termux-x11-nightly
pkg install -y tur-repo
pkg install -y termux-api
pkg install -y pulseaudio
pkg install -y proot-distro
pkg install -y rsync
pkg install -y micro
pkg install -y wget curl
pkg install -y which

termux-microphone-record -d 4

mkdir -p ~/Temp-HWA
cd ~/Temp-HWA

wget -O mesa-zink_23.0.4-5_aarch64.deb \
https://github.com/Prime-TITAN-CameraMan/Termux-Desktop/releases/download/v23.0.4-5/mesa-zink_23.0.4-5_aarch64.deb
wget -O mesa-zink-dev_23.0.4-5_all.deb \
https://github.com/Prime-TITAN-CameraMan/Termux-Desktop/releases/download/v23.0.4-5/mesa-zink-dev_23.0.4-5_all.deb

apt install -y ./*.deb
apt install -y virglrenderer-mesa-zink vulkan-loader-generic angle-android virglrenderer-android \
libandroid-shmem libc++ libdrm libx11 libxcb libxshmfence libwayland zlib zstd
apt --fix-broken install -y

wget -O vulkan-icd.deb \
https://github.com/Prime-TITAN-CameraMan/Termux-Desktop/releases/download/v25.0.0-2/vulkan-wrapper-android_25.0.0-2_aarch64.deb

apt install -y ./vulkan-icd.deb
apt --fix-broken install -y

cd ~
rm -rf ~/Temp-HWA

pkg install -y glmark2
pkg install -y vkmark

pkg install -y openssh gh git tigervnc-viewer
pkg install -y firefox
pkg install -y mpv
pkg install -y cava
pkg install -y mousepad
pkg install -y sl
pkg install -y dwm
pkg install -y thunar thunar-archive-plugin
pkg install -y st
pkg install -y feh
pkg install -y xterm

pkg install -y python 
pip install requests

mkdir ~/WD-Wood
cd ~/WD-Wood

wget -O waifudownloader_0.2.10_aarch64.deb https://github.com/Prime-TITAN-CameraMan/Termux-Desktop/releases/download/v0.2.10/waifudownloader_0.2.10_aarch64.deb
apt install -y ./waifudownloader_0.2.10_aarch64.deb

cd ~
rm -rf ~/WD-Wood

mkdir -p ~/Thai-TCM-Config
cd ~/Thai-TCM-Config

wget -O TCM-Backup.tar.xz \
"https://github.com/tcm-tech-07/Termux-Stuffs-Private/releases/download/untagged-c260efbce3816bcb9c75/DWM-backup.tar.xz"

tar -xvf TCM-Backup.tar.xz
rm -rf TCM-Backup.tar.xz

cd ~
rsync -avh ~/Thai-TCM-Config/ ~/
rm -rf ~/Thai-TCM-Config TCM-Temp Temp-TCM 
source ~/.bashrc

mkdir -p ~/.local/bin

mkdir ~/Git-Temp
cd ~/Git-Temp

git clone https://github.com/novnc/websockify.git
cd websockify

pip install . --no-deps

cd ~
rm -rf ~/Git-Temp

proot-distro install debian

proot-distro login debian --shared-tmp -- /bin/bash << 'EOF'
apt update
apt upgrade -y
apt install -y sudo nano adduser dbus-x11 libasound2
apt install -y wget
EOF

cd ~
mkdir ~/Temp-TCM

echo "Done, check everything if works"
