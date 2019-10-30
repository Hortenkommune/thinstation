#!/bin/bash
touch /tmp/thinstation/ts/etc/READ
touch /tmp/thinstation/ts/etc/support.love
cp -a /tmp/hkthin/machine/. /tmp/thinstation/ts/build/machine/
cp -a /tmp/hkthin/thinstation.conf.buildtime /tmp/thinstation/ts/build/thinstation.conf.buildtime
cat /tmp/hkthin/hkbuild.conf /tmp/hkthin/passwd.conf > /tmp/thinstation/ts/build/build.conf.example
cd /tmp/thinstation
. setup-chroot -i -b
pause