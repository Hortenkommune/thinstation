#!/bin/bash
BUILD_VERSION=2.4.0
basepath=thinstation
prep=prepare
bootimages=thinstation/build/boot-images

rm -rf /$prep

git clone --depth 1 git://github.com/Hortenkommune/$basepath /$prep --single-branch --branch beta

cp -TR /$prep/machine/. /$basepath/ts/build/machine/ \
  && cp -TR /$prep/packages/hdupdate/hdupdate.service /$basepath/ts/build/packages/hdupdate/etc/systemd/system/hdupdate.service \
  && cp -TR /$prep/packages/hdupdate/hdupdate /$basepath/ts/build/packages/hdupdate/etc/init.d/hdupdate \
  && cp -TR /$prep/packages/versionchecker/. /$basepath/ts/build/packages/versionchecker/ \
  && cp -TR /$prep/packages/assetreporter/. /$basepath/ts/build/packages/assetreporter/ \
  && cp -TR /$prep/packages/fwconf/. /$basepath/ts/build/packages/fwconf/ \
  && cp -TR /$prep/packages/keyboardsync/. /$basepath/ts/build/packages/keyboardsync/ \
  && cp -TR /$prep/packages/ntpsync/. /$basepath/ts/build/packages/ntpsync/ \
  && cp -TR /$prep/theme/splash/. /$basepath/ts/build/utils/tools/splash/default/ \
  && cp -TR /$prep/theme/wallpaper.jpg /$basepath/ts/build/backgrounds/wallpaper.jpg \
  && cp -TR /$prep/conf/build.conf /$basepath/ts/build/build.conf.example 

sed -e "s/\${BUILD_VERSION}/${BUILD_VERSION}/" /$prep/conf/$basepath.conf.buildtime > /$basepath/ts/build/$basepath.conf.buildtime

rm /data/secret -f
rootpasswd=$(date +%s | sha256sum | base64 | head -c 16 ; echo)
sleep 1
tsuserpasswd=$(date +%s | sha256sum | base64 | head -c 16 ; echo)
echo param rootpasswd $rootpasswd >> /data/secret
echo param tsuserpasswd $tsuserpasswd >> /data/secret

cat /data/url.conf | head -n2 >> /$basepath/ts/build/build.conf.example 
cat /data/url.conf | tail -n3 >> /$basepath/ts/build/thinstation.conf.buildtime
cat /data/iptables.rules >> /$basepath/ts/build/packages/fwconf/etc/iptables.rules
cat /data/secret >> /$basepath/ts/build/build.conf.example

icabuildurl=$(cat /$basepath/ts/build/build.urls | grep "linuxx")
icafilename=${icabuildurl#*file://downloads/}
ahref=$(curl -s https://www.citrix.com/downloads/workspace-app/legacy-workspace-app-for-linux/workspace-app-for-linux-2012.html | grep linuxx64 | grep tar.gz | sed -r 's/^.+rel="([^"]+)".+$/\1/')
IFS=' '
read -ra ADDR <<< "$ahref"
tarbLink="${ADDR/"//"/"https://"}"
wget ${tarbLink} -O /$basepath/downloads/$icafilename

chmod +x /$basepath/ts/build/packages/keyboardsync/bin/keyboardsync.sh
chmod +x /$basepath/ts/build/packages/versionchecker/bin/versionchecker.sh
chmod +x /$basepath/ts/build/packages/assetreporter/bin/assetreporter.sh

cd /$basepath/
./setup-chroot -b -o --autodl

if [ ! -d "/data/boot-images" ]; then
  mkdir /data/boot-images
fi

cp -TR /$bootimages/pxe/. /data/boot-images/pxe \
  && cp -TR /$prep/conf/default /data/boot-images/pxe/boot/pxelinux/pxelinux.cfg/default \
  && cp -TR /$bootimages/syslinux/. /data/boot-images/syslinux \
  && cp -TR /$bootimages/refind-iso/. /data/boot-images/refind-iso
  
sed -e "s/\${BUILD_VERSION}/${BUILD_VERSION}/" /$prep/conf/network/thinstation.conf.network > /data/boot-images/pxe/thinstation.conf.network
