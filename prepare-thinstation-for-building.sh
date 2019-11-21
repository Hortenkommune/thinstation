#!/bin/bash
basepath=thinstation
prep=prepare
bootimages=thinstation/build/boot-images
rm -rf /$prep
git clone --depth 1 git://github.com/Hortenkommune/$basepath /$prep --single-branch --branch master
cp -TR /$prep/machine/. /$basepath/ts/build/machine/
cp -TR /$prep/conf/$basepath.conf.buildtime /$basepath/ts/build/$basepath.conf.buildtime
cp -TR /$prep/theme/splash/. /$basepath/ts/build/utils/tools/splash/default/
cp -TR /$prep/theme/wallpaper.jpg /$basepath/ts/build/backgrounds/wallpaper.jpg
paswd=$(date +%s | sha256sum | base64 | head -c 16 ; echo) 
echo param rootpasswd $paswd > /data/secret
cat /$prep/conf/build.conf /data/secret > /$basepath/ts/build/build.conf.example
cat /data/url.conf | head -n2 >> /$basepath/ts/build/build.conf.example && cat /data/url.conf | tail -n1 >> /$basepath/ts/build/thinstation.conf.buildtime
icabuildurl=$(cat /$basepath/ts/build/build.urls | grep "linuxx")
icafilename=${icabuildurl#*file://downloads/}
ahref=$(curl -s https://www.citrix.com/downloads/workspace-app/linux/workspace-app-for-linux-latest.html | grep linuxx64 | grep tar.gz | sed -r 's/^.+rel="([^"]+)".+$/\1/')
IFS=' '
read -ra ADDR <<< "$ahref"
tarbLink="${ADDR/"//"/"https://"}"
wget ${tarbLink} -O /$basepath/downloads/$icafilename
cd /$basepath/
./setup-chroot -b -o --autodl
if [ ! -d "/data/boot-images" ]; then
  mkdir /data/boot-images
fi
cp -TR /$prep/conf/network/. /data/boot-images/pxe
cp -TR /$bootimages/pxe/. /data/boot-images/pxe
cp -TR /$bootimages/syslinux/. /data/boot-images/syslinux