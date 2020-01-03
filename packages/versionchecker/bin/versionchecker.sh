#!/bin/bash
set -e 
set -o pipefail
service="wfica"
servicename="Citrix Workspace"
serverip=$(export | /bin/grep SERVER_IP | /bin/busybox/cut -d '"' -f2)
currentver="$(/bin/grep HDUPDATE_WS /etc/thinstation.defaults | /bin/busybox/sed 's/^HDUPDATE_WS_VERSION=//')"
requiredver="$(/bin/curl -s ${serverip}/thinstation.conf.network | /bin/grep HDUPDATE_SERVER | /bin/busybox/sed 's/^HDUPDATE_SERVER_VERSION=//')"

if [ -z "$requiredver" ]
then
      echo "Required version variable is empty, stopping..."
      exit
else
      echo "Required version variable is NOT empty, continuing..."
fi

if [ "$(/bin/busybox/printf '%s\n' "$requiredver" "$currentver" | /fastboot/bin/sort -V | /bin/busybox/head -n1)" = "$requiredver" ]; then 
        echo "Current server version is $requiredver, installed version is $currentver"
        echo "No updated needed, continuing..."
else
        echo "Current server version is $requiredver, installed version is $currentver"
        echo "Update is needed, executing update crew..."
        echo "Checking if $servicename is still running"
        while /bin/busybox/pgrep "$service" > /dev/null ; do /bin/busybox/sleep 10 ; echo "$servicename is still active." ; done
        echo "This system needs to reboot to update."
        /sbin/reboot
fi
