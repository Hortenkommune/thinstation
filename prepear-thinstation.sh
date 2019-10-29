#!/bin/bash
git clone --depth 1 git://github.com/Hortenkommune/thinstation /tmp/hkthin
git clone --depth 1 git://github.com/Thinstation/thinstation.git -b 6.2-Stable /tmp/thinstation
touch /tmp/thinstation/ts/etc/READ
touch /tmp/thinstation/ts/etc/support.love
cp -a /tmp/hkthin/machine/. /tmp/thinstation/ts/build/machine/
cp -a /tmp/hkthin/thinstation.conf.buildtime /tmp/thinstation/ts/build/thinstation.conf.buildtime
cat /tmp/hkthin/hkbuild.conf /tmp/hkthin/passwd.conf > /tmp/thinstation/ts/build/build.conf.example