#!/bin/bash
git clone --depth 1 https://github.com/Thinstation/thinstation.git /thinstation --single-branch --branch 6.2-Stable
touch /thinstation/ts/etc/READ
touch /thinstation/ts/etc/support.love
cd /thinstation/
./setup-chroot -i
