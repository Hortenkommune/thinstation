#!/bin/bash
wget https://github.com/Thinstation/thinstation/archive/refs/tags/6.2.13.zip
mkdir thinstation
cd thinstation
bsdtar --strip-components=1 -xvf /*.zip
touch /thinstation/ts/etc/READ
touch /thinstation/ts/etc/support.love
cd /thinstation/
./setup-chroot -i
