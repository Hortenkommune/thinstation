#!/bin/bash
basepath=thinstation
prep=prepare
bootimages=thinstation/build/boot-images

rm -rf /$prep

git clone --depth 1 git://github.com/Hortenkommune/$basepath /$prep --single-branch --branch master

cp -TR /$prep/KIOSK_V/conf/$basepath.conf.buildtime /$basepath/ts/build/$basepath.conf.buildtime \
  && cp -TR /$prep/KIOSK_V/theme/splash/. /$basepath/ts/build/utils/tools/splash/default/ \
  && cp -TR /$prep/KIOSK_V/theme/wallpaper.jpg /$basepath/ts/build/backgrounds/wallpaper.jpg \
  && cp -TR /$prep/KIOSK_V/conf/build.conf /$basepath/ts/build/build.conf.example
  && cp -TR /data/hkcerts /$basepath/ts/build/packages/hkcerts

paswd=$(date +%s | sha256sum | base64 | head -c 16 ; echo)
echo param rootpasswd $paswd > /data/secret

cat /data/secret | head -n1 >> /$basepath/ts/build/build.conf.example
echo "SESSION_1_FIREFOX_HOMEPAGE=\"${1}\"" >> /$basepath/ts/build/$basepath.conf.buildtime
sed -i 's/param firefoxurl.*/param firefoxurl        https:\/\/download-installer.cdn.mozilla.net\/pub\/firefox\/releases\/71.0\/linux-x86_64\/nb-NO\/firefox-71.0.tar.bz2/g' thinstation/build/build.urls       
cd /$basepath/
./setup-chroot -b -o --autodl --allmodules

if [ ! -d "/data/boot-images" ]; then
  mkdir /data/boot-images
fi

cp -TR /$bootimages/syslinux/. /data/boot-images/syslinux \
  && cp -TR /$bootimages/iso/. /data/boot-images/iso