#!/bin/bash
basepath=thinstation
kernelversion=5.15.40
git clone --depth 1 https://github.com/Thinstation/thinstation.git /thinstation --single-branch --branch 6.2-Stable
touch /thinstation/ts/etc/READ
touch /thinstation/ts/etc/support.love
cd /$basepath
echo $kernelversion > /$basepath/ts/ports/kernel-modules/VERSION
./setup-chroot -i
./setup-chroot -e "rebuild-kernels -a"
