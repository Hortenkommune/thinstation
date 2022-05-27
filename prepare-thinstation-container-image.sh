#!/bin/bash
basepath=thinstation
kernelversion=5.15.41

git clone --depth 1 https://github.com/Thinstation/thinstation.git /$basepath --single-branch --branch 6.2-Stable
touch /$basepath/ts/etc/READ
touch /$basepath/ts/etc/support.love
echo $kernelversion > /$basepath/ts/ports/kernel-modules/VERSION

cd /$basepath
#./setup-chroot -i
./setup-chroot -e "rebuild-kernels -a"
