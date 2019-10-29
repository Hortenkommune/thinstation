#!/bin/bash
git clone --depth 1 git://github.com/Hortenkommune/thinstation /tmp/hkthin
git clone --depth 1 git://github.com/Thinstation/thinstation.git -b 6.2-Stable /tmp/thinstation
touch /tmp/thinstation/ts/etc/READ \
touch /tmp/thinstation/ts/etc/support.love