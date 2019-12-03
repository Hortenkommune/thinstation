#!/bin/bash
echo "Positional Parameter:"
echo '$0 = ' $0
echo '$1 = ' $1

basepath=thinstation
prep=prepare
bootimages=thinstation/build/boot-images

rm -rf /$prep

git clone --depth 1 git://github.com/Hortenkommune/$basepath /$prep --single-branch --branch master

cp -TR /$prep/KIOSK_V/conf/$basepath.conf.buildtime /$basepath/ts/build/$basepath.conf.buildtime \
  && cp -TR /$prep/KIOSK_V/theme/splash/. /$basepath/ts/build/utils/tools/splash/default/ \
  && cp -TR /$prep/KIOSK_V/theme/wallpaper.jpg /$basepath/ts/build/backgrounds/wallpaper.jpg \
  && cp -TR /$prep/KIOSK_V/conf/build.conf /$basepath/ts/build/build.conf.example

paswd=$(date +%s | sha256sum | base64 | head -c 16 ; echo) 
echo param rootpasswd $paswd > /data/secret

cat /data/secret | head -n1 >> /$basepath/ts/build/build.conf.example
echo "SESSION_1_FIREFOX_HOMEPAGE=\"${1}\"" >> /$basepath/ts/build/$basepath.conf.buildtime

cd /$basepath/
./setup-chroot -b -o --autodl --allmodules

if [ ! -d "/data/boot-images" ]; then
  mkdir /data/boot-images
fi

cp -TR /$prep/conf/network/. /data/boot-images/pxe \
  && cp -TR /$bootimages/pxe/. /data/boot-images/pxe \
  && cp -TR /$bootimages/syslinux/. /data/boot-images/syslinux