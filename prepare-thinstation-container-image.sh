#!/bin/bash
wget https://github.com/Thinstation/thinstation/archive/refs/tags/6.2.13.zip
mkdir thinstation
cd thinstation
bsdtar --strip-components=1 -xvf /*.zip
#git clone --depth 1 https://github.com/Thinstation/thinstation.git /thinstation --single-branch --branch 6.2-Stable
touch /thinstation/ts/etc/READ
touch /thinstation/ts/etc/support.love
cd /thinstation/
./setup-chroot -i
