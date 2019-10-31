#!/bin/bash
cat /tmp/hkthin/hkbuild.conf /tmp/hkthin/passwd.conf > /tmp/thinstation/ts/build/build.conf.example
cd /tmp/thinstation
. setup-chroot -i -b
pause