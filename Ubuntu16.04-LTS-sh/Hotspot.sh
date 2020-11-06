#!/usr/bin/bash

kernel_version=$(uname -r)

if [[ ${kernel_version} != 4.19.0-6-* ]]; then
	echo "your kernel version is not 4.19!"
	exit
fi

echo "begin install perf and image-dbg"
sudo apt install linux-perf-4.19 linux-image-4.19.0-6-amd64-dbg

echo "begin clone hotspot"
git clone https://github.com/KDAB/hotspot.git
cd hotspot/
git submodule update --init --recursive
cd ..
echo "begin install depends"
sudo apt build-dep hotspot

sudo apt install libkf5notifications-dev libqt5svg5-dev

sysctl_conf=$(tail -n 1 /etc/sysctl.conf)
if [ ${sysctl_conf} != ""kernel.perf_event_paranoid = -1 ]; then
	sudo tee -a /etc/sysctl.conf <<< "kernel.perf_event_paranoid = -1"
fi

echo "begin build hotspot"
mkdir ./hotspot/build
cd ./hotspot/build

cmake ..
make -j8

sudo make install

echo "install over, please reboot your system!"
