#!/bin/bash
git clone --depth 1 git://github.com/Hortenkommune/thinstation /prepare
cp -a /prepare/machine/. /thinstation/ts/build/machine/
cp -a /prepare/conf/thinstation.conf.buildtime /thinstation/ts/build/thinstation.conf.buildtime
cat /prepare/conf/build.conf /data/passwd.conf > /thinstation/ts/build/build.conf.example
icabuildurl=$(cat /thinstation/ts/build/build.urls | grep "linuxx")
icafilename=${icabuildurl#*file://downloads/}
ahref=$(curl -s https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html | grep linuxx64 | grep tar.gz | sed -r 's/^.+rel="([^"]+)".+$/\1/')
IFS=' '
read -ra ADDR <<< "$ahref"
tarbLink="${ADDR/"//"/"https://"}" 
wget ${tarbLink} -O /thinstaion/downloads/$icafilename
cd /thinstation/
./setup-chroot -b -o --autodl