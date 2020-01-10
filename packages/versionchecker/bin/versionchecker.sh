#!/bin/bash
set -e 
set -o pipefail
service="wfica"
servicename="Citrix Workspace"
serverip="$(grep "HDUPDATE_SERVER=" /etc/thinstation.defaults | sed 's/^HDUPDATE_SERVER=//')"
currentver="$(grep HDUPDATE_WS /etc/thinstation.defaults | sed 's/^HDUPDATE_WS_VERSION=//')"
reqcurl="$(curl -s ${serverip}/thinstation.conf.network | head -n1)"
requiredver="$(echo $reqcurl | sed 's/^HDUPDATE_SERVER_VERSION=//')"

if [ -z "$requiredver" ]
then
      echo "Required version variable is empty, stopping..."
      exit
else
      echo "Required version variable is NOT empty, continuing..."
fi

if [ "$currentver" = "$requiredver" ]; then 
        echo "Current server version is $requiredver, installed version is $currentver"
        echo "No updated needed, continuing..."
else
        echo "Current server version is $requiredver, installed version is $currentver"
        echo "Update is needed, executing update crew..."
        echo "Checking if $servicename is still running"
        while pgrep "$service" > /dev/null ; do sleep 10 ; echo "$servicename is still active." ; done
        echo "$servicename is not active, system is rebooting to update."
        /sbin/reboot
fi
